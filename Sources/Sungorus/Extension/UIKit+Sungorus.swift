import UIKit


@discardableResult
public func sgrEnqueueTask(_ task: NavigationTask, queue: NavigationQueue = .main) -> NavigationTask {
    queue.add(task)
    return task
}

public extension UIWindow {
    @discardableResult
    func sgrEnqueueSwitchRoot(
        to viewController: UIViewController,
        animated: Bool,
        duration: TimeInterval = 0.5,
        options: UIView.AnimationOptions?
    ) -> NavigationTask {
        let task = SwitchRootNavigationTask(window: self, viewController: viewController, animated: true)
        task.animationDuration = duration
        options.map { task.animationOptions = $0 }
        return sgrEnqueueTask(task)
    }
}

public extension UIViewController {
    @discardableResult
    func sgrEnqueuePresent(_ presentable: UIViewController, animated: Bool) -> NavigationTask {
        let task = PresentNavigationTask(source: self, presentable: presentable, animated: animated)
        return sgrEnqueueTask(task)
    }

    @discardableResult
    func sgrEnqueueDismiss(animated: Bool) -> NavigationTask {
        let task = DismissNavigationTask(presented: self, animated: animated)
        return sgrEnqueueTask(task)
    }

    @discardableResult
    func sgrEnqueueDismissAsPresenter(animated: Bool) -> NavigationTask {
        let task = DismissNavigationTask(presentationContext: self, animated: animated)
        return sgrEnqueueTask(task)
    }
}

public extension UINavigationController {
    @discardableResult
    func sgrEnqueuePush(_ viewController: UIViewController, animated: Bool) -> NavigationTask {
        let task = PushNavigationTask(navigationController: self, viewController: viewController, animated: animated)
        return sgrEnqueueTask(task)
    }

    @discardableResult
    func sgrEnqueuePop(animated: Bool) -> NavigationTask {
        let task = PopNavigationTask(navigationController: self, animated: animated)
        return sgrEnqueueTask(task)
    }

    @discardableResult
    func sgrEnqueuePopTo(_ destination: UIViewController, animated: Bool) -> NavigationTask {
        let task = PopNavigationTask(navigationController: self, destination: destination, animated: animated)
        return sgrEnqueueTask(task)
    }

    @discardableResult
    func sgrEnqueuePopToRoot(animated: Bool) -> NavigationTask {
        let task = PopToRootNavigationTask(navigationController: self, animated: animated)
        return sgrEnqueueTask(task)
    }
}
