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

class CMGithubProvider {
    
    static let shared: CMGithubProvider = CMGithubProvider()
    
    let provider: MoyaProvider<CMGithubApi> = MoyaProvider()
    let cacheProvider: Any = "CacheProvider"
    
    func search(_ query: String) -> Observable<CMGithubRepositorySearchResponse> {
        return self.provider.rx.request(.searchRepositories(query: query))
            .asObservable()
            .map(CMGithubRepositorySearchResponse.self)
            //            .catchErrorJustReturn(CMGithubRepositorySearchResponse()) TODO: return data from the cache
            .asObservable()
    }
    
    func getBranches(forRepository repositoryName: String, ownerId: String) -> Observable<[CMBranch]> {
        return self.provider.rx.request(.getBranches(ownerId: ownerId, repositoryName: repositoryName))
            .asObservable()
            .map([CMBranch].self)
            //            .catchErrorJustReturn(CMGithubRepositorySearchResponse()) TODO: return data from the cache
            .asObservable()
    }
    
    func getCollaborators(forRepository repositoryName: String, ownerId: String) -> Observable<[CMCollaborator]> {
        return self.provider.rx.request(.getCollaborators(ownerId: ownerId, repositoryName: repositoryName))
            .asObservable()
            .map([CMCollaborator].self)
            //            .catchErrorJustReturn(CMGithubRepositorySearchResponse()) TODO: return data from the cache
            .asObservable()
    }
    
}
