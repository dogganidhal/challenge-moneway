//
//  GithubRepository.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 11/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation

struct CMGithubRepository: Codable {
    
    let id: Int
    let nodeId: String
    let name: String
    let owner: CMGithubUser
    let fullName: String
    let `private`: Bool
    let htmlUrl: String
    let description: String
    let fork: Bool
    let createdAt: Date
    let updatedAt: Date
    let pushedAt: Date
    let homePage: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String
    let forkCount: Int
    let openIssuesCount: Int
    let masterBranch: String
    let defaultBranch: String
    let score: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case owner
        case fullName = "full_name"
        case `private`
        case htmlUrl = "html_url"
        case description
        case fork
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homePage = "home_page"
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forkCount = "fork_count"
        case openIssuesCount = "open_issues_count"
        case masterBranch = "master_branch"
        case defaultBranch = "default_branch"
        case score
    }
    
}
