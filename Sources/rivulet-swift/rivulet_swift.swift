// The Swift Programming Language
// https://docs.swift.org/swift-book

import RivuletProtos
import SwiftProtobuf

// 类型别名
typealias _RivuletRequest = Com_Rivuletkit_Common_Collection_Request
typealias _RivuletResponse = Com_Rivuletkit_Common_Collection_Response

// 处理接口
protocol RivuletHandleInterface {
    // 请求实现
    func Reply(request: RivuletRequest) throws -> RivuletResponse?
}

// 上下文
class RivuletContext {
    internal var iRivuletHandle: RivuletHandleInterface

    init(handle: RivuletHandleInterface) {
        iRivuletHandle = handle
    }
}

// 数据基类
class RivuletBaseDataClass<T: SwiftProtobuf.Message> {
    internal var context: RivuletContext
    internal var instance: T

    internal init(context: RivuletContext, instance: T) {
        self.context = context
        self.instance = instance
    }

    // json 解码
    convenience init(context: RivuletContext, jsonString: String) throws {
        self.init(
            context: context,
            instance: try T(jsonString: jsonString)
        )
    }

    // json 编码
    func jsonString() throws -> String {
        return try instance.jsonString()
    }
}

// Request 类
class RivuletRequest: RivuletBaseDataClass<_RivuletRequest> {
    public func Reply() throws -> RivuletResponse? {
        return try context.iRivuletHandle.Reply(request: self)
    }
}

// Response 类
class RivuletResponse: RivuletBaseDataClass<_RivuletResponse> {}
