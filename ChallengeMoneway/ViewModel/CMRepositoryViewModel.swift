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

enum CMRepositoryTableViewSection {
    case branches(branches: [CMBranch])
    case collaborators(collaborators: [CMCollaborator])
}

struct CMRepositoryViewModel {
    
    private let provider: CMGithubProvider = CMGithubProvider()
    private let repository: CMGithubRepository
    
    lazy var sections: Observable<[CMRepositoryTableViewSection]> = Observable.combineLatest(
            self.provider.getBranches(forRepository: self.repository.name, ownerId: self.repository.owner.login),
            self.provider.getCollaborators(forRepository: self.repository.name, ownerId: self.repository.owner.login)
        )
        .flatMap { (branches, collaborators) -> Observable<[CMRepositoryTableViewSection]> in
            return Observable.of([
                CMRepositoryTableViewSection.collaborators(collaborators: collaborators),
                CMRepositoryTableViewSection.branches(branches: branches)
            ])
        }
    
    init(_ repository: CMGithubRepository) {
        self.repository = repository
    }
    
}
