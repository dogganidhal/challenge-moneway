//
//  CMCachedUser.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CMCachedUser : Object {
    
    @objc dynamic var login: String = ""
    @objc dynamic var avatarUrl: String = ""
    
    var githubUser: CMGithubUser {
        return CMGithubUser(login: self.login, avatarUrl: self.avatarUrl)
    }
    
    init(withUser user: CMGithubUser) {
        self.login = user.login
        self.avatarUrl = user.avatarUrl
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
        return "login"
    }
    
}
