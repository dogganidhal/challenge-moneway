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

class CMSearchViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    let disposeBag: DisposeBag = DisposeBag()
    let provider: MoyaProvider<CMGithubApi> = MoyaProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeToSearchBarEvents()
    }

    private func subscribeToSearchBarEvents() {
        self.searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { event in
                switch(event) {
                case .completed:
                    break
                case .next(_):
                    break
                case .error(_):
                    break
                }
            }
            .disposed(by: self.disposeBag)
    }

}

