import UIKit

open class PushNavigationTask: NavigationTask, StackNavigation {
    public let navigationController: UINavigationController
    public let viewController: UIViewController

    public init(
        navigationController: UINavigationController,
        viewController: UIViewController,
        animated: Bool
    ) {
        self.navigationController = navigationController
        self.viewController = viewController
        super.init(animated: animated)
    }

    open override func executeNavigation() {
        navigationController.pushViewController(viewController, animated: animated)
        setUpHandlerOnNavigationCompleted()
    }
}
