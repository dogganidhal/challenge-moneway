//
//  CMCachedContributor.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CMCachedContributor : Object {
    
    @objc dynamic var login: String = ""
    @objc dynamic var avatarUrl: String = ""
    @objc dynamic var repositoryFullName: String = ""
    
    var githubContributor: CMContributor {
        return CMContributor(login: self.login, avatarUrl: self.avatarUrl)
    }
    
    init(withContributor contributor: CMContributor, repositoryFullName: String) {
        super.init()
        self.login = contributor.login
        self.avatarUrl = contributor.avatarUrl
        self.repositoryFullName = repositoryFullName
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
        return "login"
    }
    
}
