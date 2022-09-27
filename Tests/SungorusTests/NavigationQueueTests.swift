import Foundation
@testable import Sungorus
import XCTest

final class NavigationQueueTests: XCTestCase {
    func test_init() {
        let sut = NavigationQueue(name: "NavigationQueueTests")

        XCTAssertEqual(sut.operationQueue.name, "NavigationQueueTests")
        XCTAssertEqual(sut.operationQueue.maxConcurrentOperationCount, 1)
        XCTAssertEqual(sut.operationQueue.qualityOfService, .userInteractive)
    }

    func test_addMethodCall() {
        let mock = NavigationTaskMock()
        let sut = NavigationQueue.main

        sut.add(mock)

        XCTAssertFalse(mock.executeNavigationMethodCalled)
        let promise = expectation(description: "Task should finish execution")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(mock.executeNavigationMethodCalled)
            XCTAssertFalse(mock.isExecuting)
            XCTAssertTrue(mock.isFinished)
            promise.fulfill()
        }
        waitForExpectations(timeout: 3.0)
    }

    func test_operationsAreExecutedInTheOrderAdded() {
        var executedTasks: [String] = []
        let tasks: [NavigationTask] = [
            NavigationTaskMock(onExecuting: {
                executedTasks.append("0")
            }),
            NavigationTaskMock(onExecuting: {
                executedTasks.append("1")
            }),
            NavigationTaskMock(onExecuting: {
                executedTasks.append("2")
            }),
        ]
        let sut = NavigationQueue.main

        tasks.forEach(sut.add)

        let promise = expectation(description: "Tasks should be executed in the order added")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(executedTasks, ["0", "1", "2"])
            promise.fulfill()
        }
        waitForExpectations(timeout: 3.0)
    }
}

private class NavigationTaskMock: NavigationTask {
    init(onExecuting: @escaping () -> Void = { }) {
        self.onExecuteNavigationMethodCalled = onExecuting
        super.init()
    }

    var onExecuteNavigationMethodCalled: (() -> Void)?
    var executeNavigationMethodCalled: Bool = false
    override func executeNavigation() {
        executeNavigationMethodCalled = true
        onExecuteNavigationMethodCalled?()
        finish()
    }
}
