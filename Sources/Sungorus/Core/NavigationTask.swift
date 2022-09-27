import Foundation

open class NavigationTask: Operation {
    open override var isExecuting: Bool { opExecuting }
    open override var isFinished: Bool { opFinished }

    public var animated: Bool

    var opExecuting: Bool {
        willSet {
            willChangeValue(for: \.isExecuting)
        }
        didSet {
            didChangeValue(for: \.isExecuting)
        }
    }

    var opFinished: Bool {
        willSet {
            willChangeValue(for: \.isFinished)
        }
        didSet {
            didChangeValue(for: \.isFinished)
        }
    }

    public init(animated: Bool) {
        self.opExecuting = false
        self.opFinished = false
        self.animated = animated
        super.init()
    }

    open override func start() {
        if isCancelled {
            opFinished = true
            return
        }

        opExecuting = true

        DispatchQueue.main.async {
            self.executeNavigation()
        }
    }

    open func executeNavigation() {
        // This method is meant to be overridden by subclasses.
        finish()
    }

    public func finish() {
        if opExecuting {
            opExecuting = false
        }
        if !opFinished {
            opFinished = true
        }
    }
}
