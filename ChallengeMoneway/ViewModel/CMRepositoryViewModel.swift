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

class CMRepositoryViewModel {
    
    private let githubProvider: CMGithubProvider = CMGithubProvider.shared
    private let cacheProvider: CMCacheProvider = CMCacheProvider.shared
    private let repository: CMGithubRepository
    
    private lazy var branches: Observable<[CMBranch]> = self.githubProvider
        .getBranches(forRepository: self.repository.name, ownerId: self.repository.owner.login)
        .flatMapLatest { [unowned self] (branches) -> Observable<[CMBranch]> in
            self.cacheProvider.cacheBranches(branches, repositoryFullName: self.repository.fullName)
            return Observable.of(branches)
        }
        .catchError { [unowned self] (error) -> Observable<[CMBranch]> in
            return self.cacheProvider.getBranches(forRepository: self.repository.name, ownerId: self.repository.owner.login)
        }
        .ifEmpty(switchTo: self.cacheProvider.getBranches(forRepository: self.repository.name, ownerId: self.repository.owner.login))
    
    private lazy var contributors: Observable<[CMContributor]> = self.githubProvider
        .getContributors(forRepository: self.repository.name, ownerId: self.repository.owner.login)
        .flatMapLatest { [unowned self] (branches) -> Observable<[CMContributor]> in
            self.cacheProvider.cacheContributors(branches, repositoryFullName: self.repository.fullName)
            return Observable.of(branches)
        }
        .catchError { [unowned self] (error) -> Observable<[CMContributor]> in
            return self.cacheProvider.getContributors(forRepository: self.repository.name, ownerId: self.repository.owner.login)
        }
        .ifEmpty(switchTo: self.cacheProvider.getContributors(forRepository: self.repository.name, ownerId: self.repository.owner.login))
    
    lazy var sections: Observable<[CMRepositoryTableViewSection]> = Observable.combineLatest(self.branches, self.contributors)
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
