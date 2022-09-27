import UIKit

open class DismissNavigationTask: NavigationTask {
    public let presentationContext: UIViewController?

    public init(presentationContext: UIViewController?, animated: Bool) {
        self.presentationContext = presentationContext
        super.init(animated: animated)
    }

    public init(presented: UIViewController, animated: Bool) {
        presentationContext = presented.presentingViewController
        super.init(animated: animated)
    }

    open override func executeNavigation() {
        guard
            let presentationContext,
            presentationContext.presentedViewController != nil
        else {
            return finish()
        }

        presentationContext.dismiss(animated: animated) { [weak self] in
            self?.finish()
        }
    }
}
