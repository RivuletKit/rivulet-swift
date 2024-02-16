import Protos
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
        let jsonStr = try col.jsonString()

        Swift.print("[Echo] col to json: \(jsonStr)")
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
}
