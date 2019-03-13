//
//  CMSearchViewController.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 11/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class CMSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    let viewModel: CMSearchViewModel = CMSearchViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    let provider: CMGithubProvider = CMGithubProvider.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CMRepositoryCell", bundle: nil), forCellReuseIdentifier: CMRepositoryCell.reuseIdentifier)
        self.tableView.delegate = self
        self.subscribeToSearchBarEvents()
        self.setupSearchController()
    }
    
    private func setupSearchController() {
        self.definesPresentationContext = true
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.9)
        self.searchController.searchBar.placeholder = "Search Github repositories"
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
    }

    private func subscribeToSearchBarEvents() {
        
        self.searchController.searchBar.rx.text.orEmpty
            .map({ (query) -> String in
                print(query)
                return query
            })
            .bind(to: self.viewModel.query)
            .disposed(by: self.disposeBag)
        
        self.viewModel.repositories
            .drive(self.tableView.rx.items(cellIdentifier: CMRepositoryCell.reuseIdentifier, cellType: CMRepositoryCell.self)) {
                (_, repository: CMGithubRepository, cell: CMRepositoryCell) in
                cell.repository = repository
            }
            .disposed(by: self.disposeBag)
        
    }

}

extension CMSearchViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

extension CMSearchViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}
