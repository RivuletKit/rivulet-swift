// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import RivuletProtos
import SwiftProtobuf

// 类型别名
public typealias _RivuletRequest = Com_Rivuletkit_Common_Collection_Request
public typealias _RivuletResponse = Com_Rivuletkit_Common_Collection_Response

public enum RivuletError: Error, Equatable {
    case emptyResponse
    case syncReplyUnavailable
    case invalidAuth(String)
    case unsupportedAuth(String)
    case unsupportedFeature(String)
}

// 新接口: Swift 风格
public protocol RivuletHandler {
    func reply(request: RivuletRequest) throws -> RivuletResponse?
}

// 兼容旧接口
public protocol RivuletHandleInterface: RivuletHandler {
    func Reply(request: RivuletRequest) throws -> RivuletResponse?
}

public extension RivuletHandleInterface {
    func reply(request: RivuletRequest) throws -> RivuletResponse? {
        return try Reply(request: request)
    }
}

public protocol RivuletTransport {
    func send(request: RivuletRequest) async throws -> RivuletResponse
}

public struct RivuletHandlerTransport: RivuletTransport {
    private let handler: any RivuletHandler

    public init(handler: any RivuletHandler) {
        self.handler = handler
    }

    public func send(request: RivuletRequest) async throws -> RivuletResponse {
        guard let response = try handler.reply(request: request) else {
            throw RivuletError.emptyResponse
        }
        return response
    }
}

public protocol RivuletRequestProcessor {
    func send(request: RivuletRequest) async throws -> RivuletResponse
    func send(jsonString: String) async throws -> RivuletResponse
}

// 上下文
public final class RivuletContext {
    internal let transport: any RivuletTransport
    internal let handler: (any RivuletHandler)?

    public init(transport: any RivuletTransport) {
        self.transport = transport
        handler = nil
    }

    public init(handler: any RivuletHandler) {
        self.transport = RivuletHandlerTransport(handler: handler)
        self.handler = handler
    }

    @available(*, deprecated, renamed: "init(handler:)")
    public convenience init(handle: any RivuletHandleInterface) {
        self.init(handler: handle)
    }
}

// 数据基类
public class RivuletBaseDataClass<T: SwiftProtobuf.Message> {
    internal let context: RivuletContext
    public var instance: T

    public init(context: RivuletContext, instance: T) {
        self.context = context
        self.instance = instance
    }

    // json 解码
    public convenience init(context: RivuletContext, jsonString: String) throws {
        self.init(
            context: context,
            instance: try T(jsonString: jsonString)
        )
    }

    // json 编码
    public func jsonString() throws -> String {
        return try instance.jsonString()
    }
}

// Request 类
public final class RivuletRequest: RivuletBaseDataClass<_RivuletRequest> {
    public func reply() async throws -> RivuletResponse {
        return try await context.transport.send(request: self)
    }

    public func makeResponse(instance: _RivuletResponse) -> RivuletResponse {
        return RivuletResponse(context: context, instance: instance)
    }

    @available(*, deprecated, renamed: "reply()")
    public func Reply() throws -> RivuletResponse? {
        guard let handler = context.handler else {
            throw RivuletError.syncReplyUnavailable
        }
        return try handler.reply(request: self)
    }
}

// Response 类
public final class RivuletResponse: RivuletBaseDataClass<_RivuletResponse> {}

public final class RivuletClient: RivuletRequestProcessor {
    public let context: RivuletContext

    public init(context: RivuletContext) {
        self.context = context
    }

    public convenience init(transport: any RivuletTransport) {
        self.init(context: RivuletContext(transport: transport))
    }

    public convenience init(handler: any RivuletHandler) {
        self.init(context: RivuletContext(handler: handler))
    }

    public func send(request: RivuletRequest) async throws -> RivuletResponse {
        return try await request.reply()
    }

    public func send(jsonString: String) async throws -> RivuletResponse {
        let request = try RivuletRequest(context: context, jsonString: jsonString)
        return try await send(request: request)
    }
}
