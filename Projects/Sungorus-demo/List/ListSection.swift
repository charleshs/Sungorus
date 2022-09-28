//
//  ListSection.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/29.
//

import UIKit

public protocol ListSectionType: Hashable {
    var sectionIdentifier: String { get }
}

open class ListSection: Hashable, ListSectionType {
    public static func == (lhs: ListSection, rhs: ListSection) -> Bool {
        lhs.sectionIdentifier == rhs.sectionIdentifier
    }

    public let sectionIdentifier: String

    public init(
        sectionIdentifier: String = UUID().uuidString
    ) {
        self.sectionIdentifier = sectionIdentifier
    }

    open func hash(into hasher: inout Hasher) {
        sectionIdentifier.hash(into: &hasher)
    }
}
