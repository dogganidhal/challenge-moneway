//
//  CMGithubRepositorySearchResponse.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 12/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation

struct CMGithubRepositorySearchResponse: Codable {
    
    let repositories: [CMGithubRepository]
    
    enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
    
    static var empty: CMGithubRepositorySearchResponse = CMGithubRepositorySearchResponse(repositories: [])
    
}
