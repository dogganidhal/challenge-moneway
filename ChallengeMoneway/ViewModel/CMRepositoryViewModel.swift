//
//  CMRepositoryViewModel.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum CMRepositoryTableViewRowModel {
    case branch(branch: CMBranch)
    case contributor(contributor: CMContributor)
}

typealias CMRepositoryTableViewSection = SectionModel<String, CMRepositoryTableViewRowModel>

struct CMRepositoryViewModel {
    
    private let githubProvider: CMGithubProvider = CMGithubProvider()
    private let cacheProvider: CMCacheProvider = CMCacheProvider()
    private let repository: CMGithubRepository
    
    private lazy var branches: Observable<[CMBranch]> = self.githubProvider
        .getBranches(forRepository: self.repository.name, ownerId: self.repository.owner.login)
        .map { (branches) -> [CMBranch] in
            return branches
        }
    
    lazy var sections: Observable<[CMRepositoryTableViewSection]> = Observable.combineLatest(
            self.githubProvider.getBranches(forRepository: self.repository.name, ownerId: self.repository.owner.login),
            self.githubProvider.getContributors(forRepository: self.repository.name, ownerId: self.repository.owner.login)
        )
        .flatMap { (arg) -> Observable<[CMRepositoryTableViewSection]> in
            let (branches, contributors) = arg
            let brancheRows = branches.map({ (branch) -> CMRepositoryTableViewRowModel in
                return CMRepositoryTableViewRowModel.branch(branch: branch)
            })
            let contributorRows = contributors.map({ (contributor) -> CMRepositoryTableViewRowModel in
                return CMRepositoryTableViewRowModel.contributor(contributor: contributor)
            })
            
            return Observable<[CMRepositoryTableViewSection]>.of([
                CMRepositoryTableViewSection(model: "Branches", items: brancheRows),
                CMRepositoryTableViewSection(model: "Contributors", items: contributorRows)
            ])
        }
    
    init(_ repository: CMGithubRepository) {
        self.repository = repository
    }
    
}
