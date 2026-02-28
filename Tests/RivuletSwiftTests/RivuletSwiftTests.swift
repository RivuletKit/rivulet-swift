import RivuletProtos
import XCTest

@testable import RivuletSwift

final class RivuletSwiftTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

        var col = Com_Rivuletkit_Common_Collection_Collection()
        col.info = Com_Rivuletkit_Common_Collection_CollectionInfo()
        col.info.name = "hello"

        var request = Com_Rivuletkit_Common_Collection_Request()
        var url = Com_Rivuletkit_Common_Collection_URL()
        url.protocol = "https"
        url.host = "bin.zmide.com"
        url.path = "/feed"
        url.querys = []
        request.url = url
        request.method = "GET"
        request.headers = []

        let jsonStr = try request.jsonString()
        Swift.print("[Echo] request to json: \(jsonStr)")
    }

    func testExampleJsonToCollection() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

        let jsonStr = "{\"info\":{\"name\":\"hello\"}}"
        let col = try Com_Rivuletkit_Common_Collection_Collection(jsonString: jsonStr)

        Swift.print("[Echo] col name is: \(col.info.name)")
    }

    func testExampleReply() throws {
        // 实现接口
        struct InHandle: RivuletHandleInterface {
            func Reply(request: RivuletSwift.RivuletRequest) throws -> RivuletSwift.RivuletResponse? {
                Swift.print("[InHandle] request <\(request.instance.url.host)> Reply loading…")
                return nil
            }
        }

        // 构造上下文
        let context = RivuletContext(handle: RivuletUseWKWebViewReply())

        // 导入请求
        // let jsonStr = "{\"info\":{\"name\":\"hello\"}}"
        let jsonStr = "{\"url\":{\"protocol\":\"https\",\"host\":\"bin.zmide.com\",\"path\":\"/feed\"},\"method\":\"GET\"}"
        let request = try RivuletRequest(context: context, jsonString: jsonStr)

        // 发送请求
        if let response = try request.Reply() {
            Swift.print("[Reply] request <\(response.instance.code)> done…")
        } else {
            Swift.print("[Reply] request error…")
        }
    }

    func testUnsupportedAuthThrows() throws {
        let context = RivuletContext(handle: RivuletUseWKWebViewReply())
        let jsonStr = "{\"url\":{\"protocol\":\"https\",\"host\":\"bin.zmide.com\",\"path\":\"/feed\"},\"method\":\"GET\",\"auth\":{\"type\":\"oauth2\"}}"
        let request = try RivuletRequest(context: context, jsonString: jsonStr)

        XCTAssertThrowsError(try request.Reply()) { error in
            guard case RivuletError.unsupportedAuth("oauth2") = error else {
                return XCTFail("Expected unsupportedAuth(oauth2), got \(error)")
            }
        }
    }

    func testInvalidBasicAuthThrows() throws {
        let context = RivuletContext(handle: RivuletUseWKWebViewReply())
        let jsonStr = "{\"url\":{\"protocol\":\"https\",\"host\":\"bin.zmide.com\",\"path\":\"/feed\"},\"method\":\"GET\",\"auth\":{\"type\":\"basic\",\"basic\":[{\"key\":\"username\",\"value\":\"demo\",\"type\":\"string\"}]}}"
        let request = try RivuletRequest(context: context, jsonString: jsonStr)

        XCTAssertThrowsError(try request.Reply()) { error in
            guard case RivuletError.invalidAuth("basic") = error else {
                return XCTFail("Expected invalidAuth(basic), got \(error)")
            }
        }
    }

    func testUnsupportedProxyThrows() throws {
        let context = RivuletContext(handle: RivuletUseWKWebViewReply())
        let jsonStr = "{\"url\":{\"protocol\":\"https\",\"host\":\"bin.zmide.com\",\"path\":\"/feed\"},\"method\":\"GET\",\"proxy\":{\"host\":\"127.0.0.1\",\"port\":7890}}"
        let request = try RivuletRequest(context: context, jsonString: jsonStr)

        XCTAssertThrowsError(try request.Reply()) { error in
            guard case RivuletError.unsupportedFeature("proxy") = error else {
                return XCTFail("Expected unsupportedFeature(proxy), got \(error)")
            }
        }
    }

    func testSupportedBearerDoesNotThrow() throws {
        let context = RivuletContext(handle: RivuletUseWKWebViewReply())
        let jsonStr = "{\"url\":{\"protocol\":\"https\",\"host\":\"bin.zmide.com\",\"path\":\"/feed\"},\"method\":\"GET\",\"auth\":{\"type\":\"bearer\",\"bearer\":[{\"key\":\"token\",\"value\":\"abc\",\"type\":\"string\"}]}}"
        let request = try RivuletRequest(context: context, jsonString: jsonStr)

        XCTAssertNoThrow(try request.Reply())
    }
}
