//
//  CMSearchViewModel.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 13/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CMSearchViewModel {
    
    private let githubProvider: CMGithubProvider = CMGithubProvider()
    private let cacheProvider: CMCacheProvider = CMCacheProvider()
    
    let query: BehaviorRelay<String> = BehaviorRelay(value: String())
    
    lazy var repositories: Observable<[CMGithubRepository]> = self.query.asObservable()
        .throttle(0.2, scheduler: MainScheduler.instance)
        .skipWhile({ $0.count < 2 })
        .distinctUntilChanged()
        .flatMapLatest({ [unowned self] (query) -> Observable<[CMGithubRepository]> in
            return self.githubProvider.search(query)
                .do(onNext: { [unowned self] (repositories) in
                    self.cacheProvider.cacheRepositories(repositories)
                })
        })
        .catchError({ [unowned self] (error) -> Observable<[CMGithubRepository]> in
            return self.query.flatMapLatest(self.cacheProvider.search)
        })
        .ifEmpty(switchTo: self.query.flatMapLatest(self.cacheProvider.search))
        .asObservable()
    
}
