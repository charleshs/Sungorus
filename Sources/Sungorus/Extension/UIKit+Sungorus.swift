import UIKit

public extension UIViewController {
    @discardableResult
    func sgrEnqueueTask(_ task: NavigationTask, queue: NavigationQueue) -> NavigationTask {
        queue.add(task)
        return task
    }

    @discardableResult
    func sgrEnqueuePresent(_ presentable: UIViewController, animated: Bool) -> NavigationTask {
        let task = PresentNavigationTask(source: self, presentable: presentable, animated: animated)
        return sgrEnqueueTask(task, queue: .main)
    }

    @discardableResult
    func sgrEnqueueDismiss(animated: Bool) -> NavigationTask {
        let task = DismissNavigationTask(presented: self, animated: animated)
        return sgrEnqueueTask(task, queue: .main)
    }

    @discardableResult
    func sgrEnqueueDismissAsPresenter(animated: Bool) -> NavigationTask {
        let task = DismissNavigationTask(presentationContext: self, animated: animated)
        return sgrEnqueueTask(task, queue: .main)
    }
}

public extension UINavigationController {
    @discardableResult
    func sgrEnqueuePush(_ viewController: UIViewController, animated: Bool) -> NavigationTask {
        let task = PushNavigationTask(navigationController: self, viewController: viewController, animated: animated)
        return sgrEnqueueTask(task, queue: .main)
    }

    @discardableResult
    func sgrEnqueuePop(animated: Bool) -> NavigationTask {
        let task = PopNavigationTask(navigationController: self, animated: animated)
        return sgrEnqueueTask(task, queue: .main)
    }

    @discardableResult
    func sgrEnqueuePopTo(_ destination: UIViewController, animated: Bool) -> NavigationTask {
        let task = PopNavigationTask(navigationController: self, destination: destination, animated: animated)
        return sgrEnqueueTask(task, queue: .main)
    }

    @discardableResult
    func sgrEnqueuePopToRoot(animated: Bool) -> NavigationTask {
        let task = PopToRootNavigationTask(navigationController: self, animated: animated)
        return sgrEnqueueTask(task, queue: .main)
    }
}
