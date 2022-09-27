import UIKit

open class PopToRootNavigationTask: NavigationTask, StackNavigation {
    public let navigationController: UINavigationController

    public init(
        navigationController: UINavigationController,
        animated: Bool
    ) {
        self.navigationController = navigationController
        super.init(animated: animated)
    }

    open override func executeNavigation() {
        navigationController.popToRootViewController(animated: animated)
        setUpHandlerOnNavigationCompleted()
    }
}
