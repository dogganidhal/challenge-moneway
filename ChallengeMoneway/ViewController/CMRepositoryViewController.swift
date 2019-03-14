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
    let tableDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CMRepositoryTableViewSection>>(configureCell: { (dataSource, tableView, indexPath, section) -> UITableViewCell in
        switch (section) {
        case .branches(let branches):
            if let cell = tableView.dequeueReusableCell(withIdentifier: CMBranchCell.reuseIdentifier) as? CMBranchCell {
                cell.branch = branches[indexPath.row]
            }
            break
        case .collaborators(let collaborators):
            if let cell = tableView.dequeueReusableCell(withIdentifier: CMCollaboratorCell.reuseIdentifier) as? CMCollaboratorCell {
                cell.collaborator = collaborators[indexPath.row]
            }
            break
        }
        return UITableViewCell()
    }, titleForHeaderInSection: { _, index in
        return index == 0 ? "Collaborators" : "Branches"
    })
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.subscribeToViewModel()
    }
    
    private func setupTableView() {
        self.tableDataSource.configureCell = { (dataSource, tableView, indexPath, section) -> UITableViewCell in
            switch (section) {
            case .branches(let branches):
                if let cell = tableView.dequeueReusableCell(withIdentifier: CMBranchCell.reuseIdentifier) as? CMBranchCell {
                    cell.branch = branches[indexPath.row]
                }
                break
            case .collaborators(let collaborators):
                if let cell = tableView.dequeueReusableCell(withIdentifier: CMCollaboratorCell.reuseIdentifier) as? CMCollaboratorCell {
                    cell.collaborator = collaborators[indexPath.row]
                }
                break
            }
            return UITableViewCell()
        }
        self.tableDataSource.titleForHeaderInSection = { _, index in
            return index == 0 ? "Collaborators" : "Branches"
        }
    }
    
    private func subscribeToViewModel() {
        if var viewModel = self.viewModel {
            viewModel.sections
                .bind(to: self.tableView.rx.items(dataSource: self.tableDataSource))
                .disposed(by: self.disposeBag)
            
        }
    }

}
