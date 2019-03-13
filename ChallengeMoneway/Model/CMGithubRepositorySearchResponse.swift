//
//  CMGithubRepositorySearchResponse.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 12/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation

struct CMGithubRepositorySearchResponse: Codable {
    
    let totalCount: Int
    let hasMoreResults: Bool
    let repositories: [CMGithubRepository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case hasMoreResults = "incomplete_results"
        case repositories = "items"
    }
    
}
