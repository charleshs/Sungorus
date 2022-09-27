@testable import Sungorus
import XCTest

final class NavigationTaskTests: XCTestCase {
    func test_init() {
        let sut = NavigationTask()

        XCTAssertFalse(sut.opExecuting)
        XCTAssertFalse(sut.opFinished)
    }

    func test_startMethodCall() {
        let sut = NavigationTask()

        sut.start()

        XCTAssertTrue(sut.isExecuting)
        XCTAssertFalse(sut.isFinished)

        let promise = expectation(description: "Task should finish execution.")
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
            XCTAssertFalse(sut.isExecuting)
            XCTAssertTrue(sut.isFinished)
            promise.fulfill()
        }
        waitForExpectations(timeout: 3.0)
    }

    func test_startMethodCall_onCancelledTask() {
        let sut = NavigationTask()

        sut.cancel()
        sut.start()

        XCTAssertFalse(sut.isExecuting)
        XCTAssertTrue(sut.isFinished)
    }
}
