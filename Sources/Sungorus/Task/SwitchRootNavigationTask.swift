import UIKit

open class SwitchRootNavigationTask: NavigationTask {
    public let window: UIWindow
    public let viewController: UIViewController
    public var animationDuration: TimeInterval = 0.5
    public var animationOptions: UIView.AnimationOptions = .transitionFlipFromRight

    public init(
        window: UIWindow,
        viewController: UIViewController,
        animated: Bool
    ) {
        self.window = window
        self.viewController = viewController
        super.init(animated: animated)
    }

    open override func executeNavigation() {
        guard animated else {
            window.rootViewController = viewController
            return finish()
        }

        UIView.transition(
            with: window,
            duration: animationDuration,
            options: animationOptions,
            animations: {
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                self.window.rootViewController = self.viewController
                UIView.setAnimationsEnabled(oldState)
            },
            completion: { [weak self] _ in
                self?.finish()
            }
        )
    }
}
