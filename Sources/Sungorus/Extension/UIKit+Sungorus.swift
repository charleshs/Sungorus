import UIKit

public extension UIViewController {
    @discardableResult
    func sgr_navigate(task: NavigationTask, queue: NavigationQueue) -> NavigationTask {
        queue.add(task)
        return task
    }

    @discardableResult
    func sgr_present(_ presentable: UIViewController, animated: Bool) -> NavigationTask {
        let task = PresentNavigationTask(source: self, presentable: presentable, animated: animated)
        return sgr_navigate(task: task, queue: .main)
    }

    @discardableResult
    func sgr_dismiss(animated: Bool) -> NavigationTask {
        let task = DismissNavigationTask(presented: self, animated: animated)
        return sgr_navigate(task: task, queue: .main)
    }

    @discardableResult
    func sgr_dismissAsPresenter(animated: Bool) -> NavigationTask {
        let task = DismissNavigationTask(presentationContext: self, animated: animated)
        return sgr_navigate(task: task, queue: .main)
    }
}

public extension UINavigationController {
    @discardableResult
    func sgr_pushViewController(_ viewController: UIViewController, animated: Bool) -> NavigationTask {
        let task = PushNavigationTask(navigationController: self, viewController: viewController, animated: animated)
        return sgr_navigate(task: task, queue: .main)
    }

    @discardableResult
    func sgr_popViewController(animated: Bool) -> NavigationTask {
        let task = PopNavigationTask(navigationController: self, animated: animated)
        return sgr_navigate(task: task, queue: .main)
    }

    @discardableResult
    func sgr_popToViewController(_ destination: UIViewController, animated: Bool) -> NavigationTask {
        let task = PopNavigationTask(navigationController: self, destination: destination, animated: animated)
        return sgr_navigate(task: task, queue: .main)
    }

    @discardableResult
    func sgr_popToRootViewController(animated: Bool) -> NavigationTask {
        let task = PopToRootNavigationTask(navigationController: self, animated: animated)
        return sgr_navigate(task: task, queue: .main)
    }
}
