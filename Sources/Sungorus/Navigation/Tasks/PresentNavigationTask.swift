import UIKit

open class PresentNavigationTask: NavigationTask {
    public let source: UIViewController
    public let presentable: UIViewController

    public init(
        source: UIViewController,
        presentable: UIViewController,
        animated: Bool
    ) {
        self.source = source
        self.presentable = presentable
        super.init(animated: animated)
    }

    open override func executeNavigation() {
        source.present(
            presentable,
            animated: animated,
            completion: { [weak self] in
                self?.finish()
            }
        )
    }
}
