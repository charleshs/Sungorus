//
//  HomeDataAdapter.swift
//  Sungorus-demo-ios
//
//  Created by Charles Hsieh on 2022/9/28.
//

import UIKit

final class HomeDataAdapter: NSObject {
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>

    func makeDataSource(for tableView: UITableView) -> DataSource {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "title-cell")

        return DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "title-cell", for: indexPath)
            var configuration = UIListContentConfiguration.cell()
            configuration.text = itemIdentifier.title
            cell.contentConfiguration = configuration
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
}

extension HomeDataAdapter {
    struct Item {
        let id: Int
        let title: String
        let onSelect: (() -> Void)?
    }

    struct Section {
        let id: Int
    }
}

extension HomeDataAdapter.Item: Hashable {
    static func == (lhs: HomeDataAdapter.Item, rhs: HomeDataAdapter.Item) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension HomeDataAdapter.Section: Hashable {

}

extension HomeDataAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let dataSource = tableView.dataSource as? DataSource
        dataSource?.itemIdentifier(for: indexPath)?.onSelect?()
    }
}
