//
//  SwitchRootController.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/28.
//

import Sungorus
import UIKit

final class SwitchRootController: Controller {
    @IBOutlet private(set) var switchBackButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        switchBackButton.addTarget(self, action: #selector(switchBackButtonTapped), for: .touchUpInside)
    }

    @objc
    private func switchBackButtonTapped() {
        guard let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else { return }

        UIApplication.shared.getKeyWindow()?.sgrEnqueueSwitchRoot(to: homeController, animated: true)
    }
}
