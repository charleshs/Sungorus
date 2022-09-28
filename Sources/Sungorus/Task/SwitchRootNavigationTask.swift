import UIKit

open class SwitchRootNavigationTask: NavigationTask {
    public let window: UIWindow
    public let viewController: UIViewController
    public var animationDuration: TimeInterval
    public var animationOptions: UIView.AnimationOptions

    public init(
        window: UIWindow,
        viewController: UIViewController,
        animated: Bool,
        animationDuration: TimeInterval,
        animationOptions: UIView.AnimationOptions
    ) {
        self.window = window
        self.viewController = viewController
        self.animationDuration = animationDuration
        self.animationOptions = animationOptions
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
