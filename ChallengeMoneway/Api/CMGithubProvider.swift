//
//  CMGithubProvider.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 12/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class CMGithubProvider : CMProvider {
    
    static let shared: CMGithubProvider = CMGithubProvider()
    
    private let provider: MoyaProvider<CMGithubApi> = MoyaProvider()
    
    func search(_ query: String) -> Observable<[CMGithubRepository]> {
        return self.provider.rx.request(.searchRepositories(query: query))
            .asObservable()
            .map(CMGithubRepositorySearchResponse.self)
            .flatMapLatest({ (response) -> Observable<[CMGithubRepository]> in
                return Observable.of(response.repositories)
            })
            .asObservable()
    }
    
    func getBranches(forRepository repositoryName: String, ownerId: String) -> Observable<[CMBranch]> {
        return self.provider.rx.request(.getBranches(ownerId: ownerId, repositoryName: repositoryName))
            .asObservable()
            .map([CMBranch].self)
            .asObservable()
    }
    
    func getContributors(forRepository repositoryName: String, ownerId: String) -> Observable<[CMContributor]> {
        return self.provider.rx.request(.getContributors(ownerId: ownerId, repositoryName: repositoryName))
            .asObservable()
            .map([CMContributor].self)
            .asObservable()
    }
    
}
