//
//  HomeListAdapter.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/28.
//

import UIKit

final class HomeListAdapter: ListAdapter<ListSection, HomeListAdapter.Item> {
    private static let listCellId = "list-cell"

    override func makeDataSource(for collectionView: UICollectionView) -> DataSource {
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: Self.listCellId)

        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.listCellId, for: indexPath)

            if let listCell = cell as? UICollectionViewListCell {
                var configuration = UIListContentConfiguration.cell()
                configuration.text = itemIdentifier.title
                listCell.contentConfiguration = configuration
                listCell.accessories = [.disclosureIndicator(displayed: .always)]
            }

            return cell
        }
    }
}

extension HomeListAdapter {
    final class Item: ListItem {
        let title: String

        init(
            title: String,
            onSelected: (() -> Void)? = nil
        ) {
            self.title = title
            super.init(onSelected: onSelected)
        }
    }
}
