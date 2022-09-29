import Foundation

public final class NavigationQueue {
    public static let main = NavigationQueue(name: "com.sungorus.NavigationQueue.main")

    let operationQueue: OperationQueue

    init(name: String) {
        operationQueue = OperationQueue()
        operationQueue.name = name
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.qualityOfService = .userInteractive
    }

    public func add(_ operation: NavigationTask) {
        // Keeping priority the same guarantees operations are executed in the order the are added.
        operation.queuePriority = .high
        operationQueue.addOperation(operation)
    }
}
