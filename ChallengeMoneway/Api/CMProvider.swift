//
//  CMProvider.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import RxSwift

protocol CMProvider {
    
    func search(_ query: String) -> Observable<[CMGithubRepository]>
    func getBranches(forRepository repositoryName: String, ownerId: String) -> Observable<[CMBranch]>
    func getContributors(forRepository repositoryName: String, ownerId: String) -> Observable<[CMContributor]>
    
}
