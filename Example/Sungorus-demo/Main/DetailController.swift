//
//  DetailController.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/28.
//

import UIKit

final class DetailController: Controller {
    deinit {
        print("[memory mgmt] \(#function) \(self)")
    }

    convenience init(color: UIColor) {
        self.init()
        apply(background: .monochrome(color: color))
    }
}
