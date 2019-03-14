//
//  CMCachedRepository.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CMCachedRepository: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var stargazersCount: Int = 0
    @objc dynamic var language: String?
    @objc dynamic var desc: String?
    @objc dynamic var owner: CMCachedUser?
    
    var githubRepository: CMGithubRepository {
        return CMGithubRepository(
            name: self.name, owner: self.owner?.githubUser ?? CMGithubUser(login: "", avatarUrl: ""),
            fullName: self.fullName, stargazersCount: self.stargazersCount, language: self.language,
            description: self.desc
        )
    }
    
    init(withRepository repository: CMGithubRepository) {
        self.owner = CMCachedUser(withUser: repository.owner)
        self.name = repository.name
        self.fullName = repository.fullName
        self.language = repository.language
        self.desc = repository.description
        self.stargazersCount = repository.stargazersCount
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    override static func primaryKey() -> String? {
        return "fullName"
    }
    
}
