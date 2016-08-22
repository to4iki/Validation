import XCTest
import ListK
@testable import Validation

final class NonEmptyListTests: XCTestCase {

    func testInit() {
        let nel = NonEmptyList(head: 1, tail: .None)
        XCTAssert(nel.head == 1)
        XCTAssert(nel.tail == .None)
    }

    func testInitWithTailListValue() {
        let nel = NonEmptyList(head: 1, tail: [2, 3])
        XCTAssert(nel.head == 1)
        XCTAssert(nel.tail == [2, 3])
    }

    func testInitWithListValue() {
        guard let nel = NonEmptyList([1, 2, 3]) else { fatalError() }
        XCTAssert(nel.head == 1)
        XCTAssert(nel.tail == [2, 3])
    }

    func testInitWithTailNelValue() {
        let nel = NonEmptyList(head: 1, tail: NonEmptyList(head: 2, tail: [3]))
        XCTAssert(nel.head == 1)
        XCTAssert(nel.tail == [2, 3])
    }
}
