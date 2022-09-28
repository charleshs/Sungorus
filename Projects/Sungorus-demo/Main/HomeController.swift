//
//  HomeController.swift
//  Sungorus-demo
//
//  Created by Charles Hsieh on 2022/9/28.
//

import Sungorus
import UIKit

final class HomeController: Controller {
    typealias DataSource = HomeListAdapter.DataSource
    typealias Snapshot =  NSDiffableDataSourceSnapshot<Section, Item>
    typealias Section = ListSection
    typealias Item = HomeListAdapter.Item
    
    @IBOutlet private(set) var collectionView: UICollectionView! {
        didSet {
            let listLayoutConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: listLayoutConfiguration)
            collectionView.dataSource = dataSource
            collectionView.delegate = dataAdapter
        }
    }

    private lazy var dataAdapter = HomeListAdapter()
    private lazy var dataSource: DataSource = dataAdapter.makeDataSource(for: collectionView)

    override func viewDidLoad() {
        super.viewDidLoad()
        populateTableView()
    }

    private func populateTableView() {
        var snapshot = Snapshot(sections: Section())
        snapshot.appendItems([
            Item(title: "Row cannot be selected", allowsSelection: false),
            Item(title: "Switch Window's Root", onSelected: {
                let switchRootController = SwitchRootController()
                let keyWindow = UIApplication.shared.getKeyWindow()
                keyWindow?.sgrEnqueueSwitchRoot(to: switchRootController, animated: true, options: [.transitionCrossDissolve])
            }),
            Item(title: "Present and Dismiss", onSelected: { [weak self] in
                let detailController = DetailController(color: .yellow)

                self?.sgrEnqueuePresent(detailController, animated: true)
                self?.sgrEnqueueDismissAsPresenter(animated: true)
            }),
            Item(title: "Push and Pop", onSelected: { [weak self] in
                let detailController = DetailController(color: .green)

                self?.navigationController?.sgrEnqueuePush(detailController, animated: true)
                self?.navigationController?.sgrEnqueuePop(animated: true)
            }),
            Item(title: "Push, Present, Dismiss and Pop", onSelected: { [weak self] in
                let pushedController = DetailController(color: .green)
                let presentedController = DetailController(color: .yellow)

                self?.navigationController?.sgrEnqueuePush(pushedController, animated: true)
                pushedController.sgrEnqueuePresent(presentedController, animated: true)
                presentedController.sgrEnqueueDismiss(animated: true)
                self?.navigationController?.sgrEnqueuePop(animated: true)
            }),
        ])
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
}
