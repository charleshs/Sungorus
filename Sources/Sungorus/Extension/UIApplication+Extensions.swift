import UIKit

public extension UIApplication {
    @available(iOS 13.0, *)
    func getKeyWindow() -> UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })
    }
}
