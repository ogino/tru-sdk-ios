import XCTest
@testable import TruSDK

final class TrusdkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Trusdk().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}