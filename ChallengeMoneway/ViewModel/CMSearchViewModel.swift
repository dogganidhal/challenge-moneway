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
    
    lazy var repositories: Observable<[CMGithubRepository]> = self.query.asObservable()
        .throttle(0.2, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .flatMapLatest(self.provider.search)
        .asObservable()
    
}
