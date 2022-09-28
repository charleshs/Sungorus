//
//  HomeController.swift
//  Sungorus-demo
//
//  Created by Charles Hsieh on 2022/9/28.
//

import Sungorus
import UIKit

final class HomeController: Controller {
    typealias DataSource = HomeDataAdapter.DataSource
    typealias Snapshot =  NSDiffableDataSourceSnapshot<Section, Item>
    typealias Section = HomeDataAdapter.Section
    typealias Item = HomeDataAdapter.Item
    
    @IBOutlet private(set) var tableView: UITableView! {
        didSet {
            tableView.dataSource = dataSource
            tableView.delegate = dataAdapter
        }
    }

    private lazy var dataAdapter = HomeDataAdapter()
    private lazy var dataSource: DataSource = dataAdapter.makeDataSource(for: tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        populateTableView()
    }

    private func populateTableView() {
        var snapshot = Snapshot(sections: Section(id: 0))
        snapshot.appendItems([
            Item(id: 0, title: "Present and Dismiss", onSelect: { [weak self] in
                let detailController = DetailController(color: .yellow)

                self?.sgrEnqueuePresent(detailController, animated: true)
                self?.sgrEnqueueDismissAsPresenter(animated: true)
            }),
            Item(id: 1, title: "Push and Pop", onSelect: { [weak self] in
                let detailController = DetailController(color: .green)

                self?.navigationController?.sgrEnqueuePush(detailController, animated: true)
                self?.navigationController?.sgrEnqueuePop(animated: true)
            }),
            Item(id: 2, title: "Push, Present, Dismiss and Pop", onSelect: { [weak self] in
                let pushedController = DetailController(color: .green)
                let presentedController = DetailController(color: .yellow)

                self?.navigationController?.sgrEnqueuePush(pushedController, animated: true)
                pushedController.sgrEnqueuePresent(presentedController, animated: true)
                presentedController.sgrEnqueueDismiss(animated: true)
                self?.navigationController?.sgrEnqueuePop(animated: true)
            }),
        ])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
