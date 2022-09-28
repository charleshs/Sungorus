//
//  ListAdapter.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/28.
//

import UIKit

open class ListAdapter<Section: ListSectionType, Item: ListItemType>: NSObject, UICollectionViewDelegate {
    public typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>

    open func makeDataSource(for collectionView: UICollectionView) -> DataSource {
        fatalError("Subclass must override this method: makeDataSource(for:)")
    }

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let dataSource = collectionView.dataSource as? DataSource
        let selectableItem = dataSource?.itemIdentifier(for: indexPath) as? ListItemSelectable
        selectableItem?.onSelected?()
    }

    open func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        guard
            let dataSource = collectionView.dataSource as? DataSource,
            let selectableItem = dataSource.itemIdentifier(for: indexPath) as? ListItemSelectable
        else {
            return false
        }

        return selectableItem.allowsSelection
    }
}
