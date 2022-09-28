//
//  ListAdapter.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/28.
//

import UIKit

open class ListSection: Hashable {
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

open class ListItem: Hashable {
    public static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        lhs.itemIdentifier == rhs.itemIdentifier
    }

    public init(
        itemIdentifier: String = UUID().uuidString,
        onSelected: (() -> Void)? = nil
    ) {
        self.itemIdentifier = itemIdentifier
        self.onSelected = onSelected
    }

    public let itemIdentifier: String
    public var onSelected: (() -> Void)?

    open func hash(into hasher: inout Hasher) {
        itemIdentifier.hash(into: &hasher)
    }
}

open class ListAdapter<Section: ListSection, Item: ListItem>: NSObject, UICollectionViewDelegate {
    public typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

    open func makeDataSource(for collectionView: UICollectionView) -> DataSource {
        fatalError("Subclass must override this method: makeDataSource(for:)")
    }

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let dataSource = collectionView.dataSource as? DataSource
        dataSource?.itemIdentifier(for: indexPath)?.onSelected?()
    }
}
