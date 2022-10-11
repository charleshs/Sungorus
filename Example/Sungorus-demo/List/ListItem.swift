//
//  ListItem.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/29.
//

import UIKit

public protocol ListItemType: Hashable {
    var itemIdentifier: String { get }
}

public protocol ListItemSelectable {
    var allowsSelection: Bool { get }
    var onSelected: (() -> Void)? { get set }
}

open class ListItem: Hashable, ListItemType, ListItemSelectable {
    public static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        lhs.itemIdentifier == rhs.itemIdentifier
    }

    public init(
        itemIdentifier: String,
        onSelected: (() -> Void)? = nil
    ) {
        self.itemIdentifier = itemIdentifier
        self.onSelected = onSelected
    }

    public let itemIdentifier: String
    public var allowsSelection: Bool = true
    public var onSelected: (() -> Void)?

    open func hash(into hasher: inout Hasher) {
        itemIdentifier.hash(into: &hasher)
    }
}
