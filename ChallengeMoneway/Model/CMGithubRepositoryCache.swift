//
//  CMGithubRepositoryCache.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CMGithubRepositoryCache: Object {
    
    @objc dynamic var query: String = ""
    @objc dynamic var responseData: Data = Data()
    
    init(withQuery query: String, searchResponse: CMGithubRepositorySearchResponse) throws {
        super.init()
        self.query = query
        self.responseData = try JSONEncoder().encode(searchResponse)
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
    
    func deserialize() throws -> (query: String, searchResponse: CMGithubRepositorySearchResponse) {
        return (query: self.query, searchResponse: try JSONDecoder().decode(CMGithubRepositorySearchResponse.self, from: self.responseData))
    }
    
}
