import UIKit

open class PopNavigationTask: NavigationTask, StackNavigation {
    public let navigationController: UINavigationController
    public let destination: UIViewController?

    public init(
        navigationController: UINavigationController,
        destination: UIViewController? = nil,
        animated: Bool
    ) {
        self.navigationController = navigationController
        self.destination = destination
        super.init(animated: animated)
    }

    open override func executeNavigation() {
        if let destination = destination {
            navigationController.popToViewController(destination, animated: animated)
        } else {
            navigationController.popViewController(animated: animated)
        }
        setUpHandlerOnNavigationCompleted()
    }
}
