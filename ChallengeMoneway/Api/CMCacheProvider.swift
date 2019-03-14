//
//  CMCacheProvider.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 12/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import RxRealm

class CMCacheProvider : CMProvider {
    
    static let shared: CMCacheProvider = CMCacheProvider()
    
    let realm: Realm = try! Realm()
    
    func search(_ query: String) -> Observable<[CMGithubRepository]> {
        let response = self.realm.objects(CMGithubRepositoryCache.self).filter("query = '\(query)'")
        return Observable.collection(from: response)
            .flatMapLatest({ (result) -> Observable<[CMGithubRepository]> in
                
                let repositories = result.toArray()
                    .reduce([CMGithubRepository](), { (accumulator: [CMGithubRepository], cache: CMGithubRepositoryCache) -> [CMGithubRepository] in
                        let repositories = try! cache.deserialize().searchResponse.repositories
                        return accumulator + repositories
                    })
                return Observable.of(repositories)
                
            })
    }
    
    func getBranches(forRepository repositoryName: String, ownerId: String) -> Observable<[CMBranch]> {
        return Observable.of([])
    }
    
    func getContributors(forRepository repositoryName: String, ownerId: String) -> Observable<[CMContributor]> {
        return Observable.of([])
    }
    
}
