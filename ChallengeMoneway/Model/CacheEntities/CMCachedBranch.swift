//
//  CMCachedBranch.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CMCachedBranch : Object {
    
    @objc dynamic var key: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var repositoryFullName: String = ""
    
    var githubBranch: CMBranch {
        return CMBranch(name: self.name)
    }
    
    init(withBranch branch: CMBranch, repositoryFullName: String) {
        super.init()
        self.name = branch.name
        self.repositoryFullName = repositoryFullName
        self.key = "\(self.repositoryFullName)@\(self.name)"
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
        return "key"
    }
    
}
