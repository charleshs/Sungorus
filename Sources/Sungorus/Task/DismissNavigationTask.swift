import UIKit

open class DismissNavigationTask: NavigationTask {
    public let presentationContext: () -> UIViewController?

    public init(
        presentationContext: @escaping () -> UIViewController?,
        animated: Bool
    ) {
        self.presentationContext = { presentationContext() }
        super.init(animated: animated)
    }

    public convenience init(
        presentationContext: UIViewController?,
        animated: Bool
    ) {
        self.init(
            presentationContext: { presentationContext },
            animated: animated
        )
    }

    public convenience init(
        presented: UIViewController,
        animated: Bool
    ) {
        self.init(
            presentationContext: { presented.presentingViewController },
            animated: animated
        )
    }

    open override func executeNavigation() {
        guard
            let context = presentationContext(),
            context.presentedViewController != nil
        else {
            return finish()
        }

        context.dismiss(animated: animated) { [weak self] in
            self?.finish()
        }
    }
}
