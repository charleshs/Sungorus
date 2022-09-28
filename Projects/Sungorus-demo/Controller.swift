//
//  Controller.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/28.
//

import UIKit

enum Background {
    case monochrome(color: UIColor)
}

protocol BackgroundApplicable {
    func apply(background: Background)
}

class Controller: UIViewController, BackgroundApplicable {
    override func viewDidLoad() {
        super.viewDidLoad()
        apply(background: .monochrome(color: .systemBackground))
    }

    func apply(background: Background) {
        switch background {
        case .monochrome(let color):
            view.backgroundColor = color
        }
    }
}
