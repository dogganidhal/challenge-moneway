//
//  GithubRepository.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 11/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation

struct CMGithubRepository: Codable {
    
    let name: String
    let owner: CMGithubUser
    let fullName: String
    let stargazersCount: Int
    let language: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case language
        case description
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
    }
    
}
