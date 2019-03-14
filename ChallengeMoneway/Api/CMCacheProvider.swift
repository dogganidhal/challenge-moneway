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
    
    lazy var realm: Realm = try! Realm()
    
    func search(_ query: String) -> Observable<[CMGithubRepository]> {
        let response = self.realm.objects(CMCachedRepository.self).filter(NSPredicate.init(format: "fullName CONTAINS %@", query))
        return Observable.collection(from: response)
            .flatMapLatest({ (result) -> Observable<[CMGithubRepository]> in
                
                let repositories: [CMGithubRepository] = result.map({ (cachedRepository: CMCachedRepository) -> CMGithubRepository in
                    return cachedRepository.githubRepository
                })
                
                return Observable.of(repositories)
                
            })
    }
    
    func getBranches(forRepository repositoryName: String, ownerId: String) -> Observable<[CMBranch]> {
        let response = self.realm.objects(CMCachedBranch.self).filter("repositoryFullName = '\(ownerId)/\(repositoryName)'")
        return Observable.collection(from: response)
            .flatMapLatest({ (result) -> Observable<[CMBranch]> in
                
                let branches: [CMBranch] = result.map({ (cachedBranch: CMCachedBranch) -> CMBranch in
                    return cachedBranch.githubBranch
                })
                
                return Observable.of(branches)
                
            })
    }
    
    func getContributors(forRepository repositoryName: String, ownerId: String) -> Observable<[CMContributor]> {
        let response = self.realm.objects(CMCachedContributor.self).filter("repositoryFullName = '\(ownerId)/\(repositoryName)'")
        return Observable.collection(from: response)
            .flatMapLatest({ (result) -> Observable<[CMContributor]> in
                
                let contributors: [CMContributor] = result.map({ (cachedContributor: CMCachedContributor) -> CMContributor in
                    return cachedContributor.githubContributor
                })
                
                return Observable.of(contributors)
                
            })
    }
    
    func cacheRepositories(_ repositories: [CMGithubRepository]) {
        guard repositories.count > 0 else { return }
        let cachedRepositories = repositories.map { (repository) -> CMCachedRepository in
            return CMCachedRepository(withRepository: repository)
        }
        self.realm.beginWrite()
        self.realm.add(cachedRepositories, update: true)
        try? self.realm.commitWrite()
    }
    
    func cacheBranches(_ branches: [CMBranch], repositoryFullName: String) {
        guard branches.count > 0 else { return }
        let cachedBranches = branches.map { (branch) -> CMCachedBranch in
            return CMCachedBranch(withBranch: branch, repositoryFullName: repositoryFullName)
        }
        self.realm.beginWrite()
        self.realm.add(cachedBranches, update: true)
        try? self.realm.commitWrite()
    }
    
    func cacheContributors(_ contributors: [CMContributor], repositoryFullName: String) {
        guard contributors.count > 0 else { return }
        let cachedContributors = contributors.map { (contributor) -> CMCachedContributor in
            return CMCachedContributor(withContributor: contributor, repositoryFullName: repositoryFullName)
        }
        self.realm.beginWrite()
        self.realm.add(cachedContributors, update: true)
        try? self.realm.commitWrite()
    }
    
}
