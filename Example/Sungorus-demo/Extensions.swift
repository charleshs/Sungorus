//
//  Extensions.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/28.
//

import UIKit

extension NSDiffableDataSourceSnapshot {
    init(sections: SectionIdentifierType...) {
        var copy = Self()
        copy.appendSections(sections)
        self = copy
    }
}
