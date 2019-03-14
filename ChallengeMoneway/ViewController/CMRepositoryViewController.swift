//
//  CMRepositoryViewController.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CMRepositoryViewController: UIViewController {

    var repository: CMGithubRepository? {
        didSet {
            if let repository = self.repository {
                self.viewModel  = CMRepositoryViewModel(repository)
                self.navigationItem.title = repository.name
            }
        }
    }
    var viewModel: CMRepositoryViewModel?
    let disposeBag: DisposeBag = DisposeBag()
    let tableDataSource = RxTableViewSectionedReloadDataSource<CMRepositoryTableViewSection>(configureCell: { (dataSource, tableView, indexPath, section) -> UITableViewCell in
        switch (section) {
        case .branch(let branch):
            if let cell = tableView.dequeueReusableCell(withIdentifier: CMBranchCell.reuseIdentifier) as? CMBranchCell {
                cell.branch = branch
                return cell
            }
            break
        case .contributor(let contributor):
            if let cell = tableView.dequeueReusableCell(withIdentifier: CMContributorCell.reuseIdentifier) as? CMContributorCell {
                cell.contributor = contributor
                return cell
            }
            break
        }
        return UITableViewCell()
    }, titleForHeaderInSection: { dataSource, index in
        return dataSource.sectionModels[index].model
    })
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.subscribeToViewModel()
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: "CMBranchCell", bundle: nil), forCellReuseIdentifier: CMBranchCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: "CMContributorCell", bundle: nil), forCellReuseIdentifier: CMContributorCell.reuseIdentifier)
    }
    
    private func subscribeToViewModel() {
        if var viewModel = self.viewModel {
            viewModel.sections
                .bind(to: self.tableView.rx.items(dataSource: self.tableDataSource))
                .disposed(by: self.disposeBag)
        }
    }

}
