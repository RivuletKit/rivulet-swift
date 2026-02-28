import Foundation
import NIOCore
import NIOHTTP1
import NIOPosix
import XCTest

@testable import RivuletSwift

private struct RecordedRequest {
    let method: String
    let uri: String
    let headers: [String: String]
    let body: String
}

private final class RequestRecorder {
    private let queue = DispatchQueue(label: "rivulet.tests.nio.recorder")
    private var request: RecordedRequest?

    func record(_ request: RecordedRequest) {
        queue.sync {
            self.request = request
        }
    }

    func latest() -> RecordedRequest? {
        return queue.sync { request }
    }
}

private final class TestHTTPHandler: ChannelInboundHandler {
    typealias InboundIn = HTTPServerRequestPart
    typealias OutboundOut = HTTPServerResponsePart

    private let recorder: RequestRecorder
    private var head: HTTPRequestHead?
    private var bodyBuffer: ByteBuffer?

    init(recorder: RequestRecorder) {
        self.recorder = recorder
    }

    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let part = unwrapInboundIn(data)
        switch part {
        case .head(let head):
            self.head = head
            bodyBuffer = context.channel.allocator.buffer(capacity: 0)
        case .body(var buffer):
            bodyBuffer?.writeBuffer(&buffer)
        case .end:
            let requestHead = head
            var body = bodyBuffer
            let readable = body?.readableBytes ?? 0
            let requestBody = body?.readString(length: readable) ?? ""

            if let requestHead {
                var headers: [String: String] = [:]
                for header in requestHead.headers {
                    headers[header.name.lowercased()] = header.value
                }
                recorder.record(
                    RecordedRequest(
                        method: requestHead.method.rawValue,
                        uri: requestHead.uri,
                        headers: headers,
                        body: requestBody
                    )
                )
            }

            let bodyText = "nio-ok"
            var responseHeaders = HTTPHeaders()
            responseHeaders.add(name: "Content-Type", value: "text/plain")
            responseHeaders.add(name: "Set-Cookie", value: "sid=abc; Path=/")
            responseHeaders.add(name: "Content-Length", value: "\(bodyText.utf8.count)")

            let responseHead = HTTPResponseHead(
                version: .http1_1, status: .ok, headers: responseHeaders)
            context.write(wrapOutboundOut(.head(responseHead)), promise: nil)

            var buffer = context.channel.allocator.buffer(capacity: bodyText.utf8.count)
            buffer.writeString(bodyText)
            context.write(wrapOutboundOut(.body(.byteBuffer(buffer))), promise: nil)
            context.writeAndFlush(wrapOutboundOut(.end(nil)), promise: nil)
        }
    }
}

private final class NIOTestServer {
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private(set) var channel: Channel?
    let recorder = RequestRecorder()

    func start() throws -> Int {
        let bootstrap = ServerBootstrap(group: group)
            .serverChannelOption(ChannelOptions.backlog, value: 64)
            .serverChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
            .childChannelInitializer { channel in
                channel.pipeline.configureHTTPServerPipeline().flatMap {
                    channel.pipeline.addHandler(TestHTTPHandler(recorder: self.recorder))
                }
            }
            .childChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)

        let channel = try bootstrap.bind(host: "127.0.0.1", port: 0).wait()
        self.channel = channel

        guard let port = channel.localAddress?.port else {
            throw URLError(.cannotFindHost)
        }
        return port
    }

    func stop() throws {
        try channel?.close().wait()
        channel = nil
        try group.syncShutdownGracefully()
    }
}

final class RivuletNIOIntegrationTests: XCTestCase {
    func testURLSessionTransportAgainstRealNIOServer() async throws {
        let server = NIOTestServer()
        let port = try server.start()
        defer {
            try? server.stop()
        }

        let transport = RivuletURLSessionTransport()
        let client = RivuletClient(transport: transport)

        let json = """
            {
              "url": {
                "protocol": "http",
                "host": "127.0.0.1",
                "port": \(port),
                "path": "/feed"
              },
              "method": "GET"
            }
            """

        let response = try await client.send(jsonString: json)

        XCTAssertEqual(response.instance.code, 200)
        XCTAssertEqual(response.instance.body, "nio-ok")
        XCTAssertTrue(
            response.instance.headers.contains {
                $0.key.lowercased() == "content-type" && $0.value == "text/plain"
            })
        XCTAssertTrue(response.instance.cookies.contains { $0.name == "sid" && $0.value == "abc" })

        let received = server.recorder.latest()
        XCTAssertEqual(received?.method, "GET")
        XCTAssertEqual(received?.uri, "/feed")
    }

    func testURLSessionTransportSendsAuthAndBodyToNIOServer() async throws {
        let server = NIOTestServer()
        let port = try server.start()
        defer {
            try? server.stop()
        }

        let transport = RivuletURLSessionTransport()
        let client = RivuletClient(transport: transport)

        let json = """
            {
              "url": {
                "protocol": "http",
                "host": "127.0.0.1",
                "port": \(port),
                "path": "/auth"
              },
              "method": "POST",
              "auth": {
                "type": "basic",
                "basic": [
                  {"key": "username", "value": "demo"},
                  {"key": "password", "value": "pass"}
                ]
              },
              "body": {
                "mode": "RAW",
                "raw": "hello-nio"
              }
            }
            """

        _ = try await client.send(jsonString: json)

        let received = server.recorder.latest()
        XCTAssertEqual(received?.method, "POST")
        XCTAssertEqual(received?.uri, "/auth")
        XCTAssertEqual(received?.body, "hello-nio")
        XCTAssertEqual(received?.headers["authorization"], "Basic ZGVtbzpwYXNz")
    }
}
