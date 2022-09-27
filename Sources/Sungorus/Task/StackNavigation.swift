import UIKit

protocol StackNavigation {
    var navigationController: UINavigationController { get }
    var animated: Bool { get }
}

extension StackNavigation where Self: NavigationTask {
    func setUpHandlerOnNavigationCompleted() {
        guard
            animated,
            let coordinator = navigationController.transitionCoordinator
        else {
            return finish()
        }

        coordinator.animate(alongsideTransition: nil, completion: { [weak self] _ in
            self?.finish()
        })
    }
}
