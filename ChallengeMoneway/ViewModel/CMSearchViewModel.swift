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
    
    private let provider: CMGithubProvider = CMGithubProvider()
    
    let query: BehaviorRelay<String> = BehaviorRelay(value: String())
    lazy var repositories: Driver<[CMGithubRepository]> = {
       
       return query.asObservable()
            .distinctUntilChanged()
            .flatMapLatest({ (query) -> Observable<CMGithubRepositorySearchResponse> in
                return self.provider.search(query)
            })
            .map({ return $0.repositories })
            .asDriver(onErrorJustReturn: [])
        
        }()
    
}
