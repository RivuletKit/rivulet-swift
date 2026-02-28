import Foundation
import RivuletProtos
import XCTest

@testable import RivuletSwift

private struct MockSuccessTransport: RivuletTransport {
    func send(request: RivuletRequest) async throws -> RivuletResponse {
        var response = Com_Rivuletkit_Common_Collection_Response()
        response.originalRequest = request.instance
        response.code = 200
        response.status = "200 OK"
        response.body = "ok"

        return RivuletResponse(
            context: request.context,
            instance: response
        )
    }
}

private struct MockFailingTransport: RivuletTransport {
    enum Kind {
        case timeout
        case network
    }

    let kind: Kind

    func send(request _: RivuletRequest) async throws -> RivuletResponse {
        switch kind {
        case .timeout:
            throw URLError(.timedOut)
        case .network:
            throw URLError(.notConnectedToInternet)
        }
    }
}

private struct MockValidationTransport: RivuletTransport {
    func send(request: RivuletRequest) async throws -> RivuletResponse {
        let payload = request.instance

        if payload.hasAuth {
            let authType = payload.auth.type.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            let supported = ["", "noauth", "basic", "bearer", "apikey"]
            if !supported.contains(authType) {
                throw RivuletError.unsupportedAuth(authType)
            }
        }

        if payload.hasURL {
            let url = payload.url
            let hasRaw = url.hasRaw && !url.raw.isEmpty
            let hasHost = !url.host.isEmpty
            if !hasRaw && !hasHost {
                throw URLError(.badURL)
            }
        }

        if payload.hasBody, payload.body.mode == .file, payload.body.hasFile, payload.body.file.hasSrc {
            let path = payload.body.file.src
            if !FileManager.default.fileExists(atPath: path) {
                throw CocoaError(.fileReadNoSuchFile)
            }
        }

        var response = Com_Rivuletkit_Common_Collection_Response()
        response.originalRequest = payload
        response.code = 204
        response.status = "204 No Content"
        return RivuletResponse(context: request.context, instance: response)
    }
}

final class RivuletSwiftTests: XCTestCase {
    func testRequestJSONFixtureDecode() throws {
        let json = try fixtureText(at: "requests/simple_get.json")
        let request = try Com_Rivuletkit_Common_Collection_Request(jsonString: json)

        XCTAssertTrue(request.hasURL)
        XCTAssertEqual(request.url.protocol, "https")
        XCTAssertEqual(request.url.host, "bin.zmide.com")
        XCTAssertEqual(request.url.path, "/feed")
        XCTAssertEqual(request.method, "GET")
    }

    func testClientSendWithMockTransport() async throws {
        let context = RivuletContext(transport: MockSuccessTransport())
        let client = RivuletClient(context: context)
        let requestJSON = try fixtureText(at: "requests/simple_get.json")
        let expectedResponseJSON = try fixtureText(at: "expected/simple_get_response.json")
        let expectedResponse = try Com_Rivuletkit_Common_Collection_Response(jsonString: expectedResponseJSON)

        let response = try await client.send(jsonString: requestJSON)
        XCTAssertEqual(response.instance.code, expectedResponse.code)
        XCTAssertEqual(response.instance.status, expectedResponse.status)
        XCTAssertEqual(response.instance.body, expectedResponse.body)
        XCTAssertTrue(response.instance.hasOriginalRequest)
        XCTAssertEqual(response.instance.originalRequest.url.host, "bin.zmide.com")
    }

    func testUnsupportedAuthThrowsAsync() async throws {
        let context = RivuletContext(transport: MockValidationTransport())
        let client = RivuletClient(context: context)
        let json = try fixtureText(at: "requests/unsupported_auth_oauth2.json")

        do {
            _ = try await client.send(jsonString: json)
            XCTFail("Expected unsupportedAuth error")
        } catch let error as RivuletError {
            XCTAssertEqual(error, .unsupportedAuth("oauth2"))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testInvalidURLThrowsAsync() async throws {
        let context = RivuletContext(transport: MockValidationTransport())
        let client = RivuletClient(context: context)
        let json = try fixtureText(at: "requests/invalid_url.json")

        do {
            _ = try await client.send(jsonString: json)
            XCTFail("Expected badURL error")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badURL)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testMalformedFileSourceThrowsAsync() async throws {
        let context = RivuletContext(transport: MockValidationTransport())
        let client = RivuletClient(context: context)
        let json = try fixtureText(at: "requests/malformed_file_src.json")

        do {
            _ = try await client.send(jsonString: json)
            XCTFail("Expected file read error")
        } catch {
            XCTAssertTrue(error is CocoaError)
        }
    }

    func testTimeoutTransportThrows() async throws {
        let context = RivuletContext(transport: MockFailingTransport(kind: .timeout))
        let client = RivuletClient(context: context)
        let json = try fixtureText(at: "requests/simple_get.json")

        do {
            _ = try await client.send(jsonString: json)
            XCTFail("Expected timeout error")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .timedOut)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testNetworkTransportThrows() async throws {
        let context = RivuletContext(transport: MockFailingTransport(kind: .network))
        let client = RivuletClient(context: context)
        let json = try fixtureText(at: "requests/simple_get.json")

        do {
            _ = try await client.send(jsonString: json)
            XCTFail("Expected network error")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .notConnectedToInternet)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    private func fixtureText(at relativePath: String) throws -> String {
        let url = try fixtureURL(at: relativePath)
        return try String(contentsOf: url, encoding: .utf8)
    }

    private func fixtureURL(at relativePath: String) throws -> URL {
        let base = Bundle.module.resourceURL
        guard let base else {
            throw NSError(domain: "RivuletSwiftTests", code: 1)
        }

        let direct = base.appendingPathComponent(relativePath)
        if FileManager.default.fileExists(atPath: direct.path) {
            return direct
        }

        let prefixed = base.appendingPathComponent("Fixtures").appendingPathComponent(relativePath)
        if FileManager.default.fileExists(atPath: prefixed.path) {
            return prefixed
        }

        let fileName = URL(fileURLWithPath: relativePath).lastPathComponent
        if let enumerator = FileManager.default.enumerator(at: base, includingPropertiesForKeys: nil) {
            for case let candidate as URL in enumerator {
                if candidate.lastPathComponent == fileName {
                    return candidate
                }
            }
        }

        throw NSError(
            domain: "RivuletSwiftTests",
            code: 404,
            userInfo: [NSLocalizedDescriptionKey: "Fixture not found: \(relativePath)"]
        )
    }
}
