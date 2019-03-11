//
//  CMGithubApi.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 11/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation
import Moya

enum CMGithubApi: TargetType {
    
    case searchRespositories(query: String)
    case getBranches(ownerId: String, repositoryName: String)
    case getCollaborators(ownerId: String, repositoryName: String)
    
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .searchRespositories(let query):
            return "/search/repositories?q=\(query)"
        case .getBranches(let ownerId, let repositoryName):
            return "/repos/\(ownerId)/\(repositoryName)/branches"
        case .getCollaborators(let ownerId, let repositoryName):
            return "/repos/\(ownerId)/\(repositoryName)/collaborators"
        }
    }
    var method: Moya.Method {
        switch self {
        case .searchRespositories, .getBranches, .getCollaborators:
            return .get
        }
    }
    var task: Task {
        return .requestPlain
    }
    var sampleData: Data {
        switch self {
        case .getCollaborators:
            return """
            [
                {
                    "login": "octocat",
                    "id": 1,
                    "node_id": "MDQ6VXNlcjE=",
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "",
                    "url": "https://api.github.com/users/octocat",
                    "html_url": "https://github.com/octocat",
                    "followers_url": "https://api.github.com/users/octocat/followers",
                    "following_url": "https://api.github.com/users/octocat/following{/other_user}",
                    "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
                    "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
                    "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
                    "organizations_url": "https://api.github.com/users/octocat/orgs",
                    "repos_url": "https://api.github.com/users/octocat/repos",
                    "events_url": "https://api.github.com/users/octocat/events{/privacy}",
                    "received_events_url": "https://api.github.com/users/octocat/received_events",
                    "type": "User",
                    "site_admin": false,
                    "permissions": {
                        "pull": true,
                        "push": true,
                        "admin": false
                    }
                }
            ]
            """.data(using: .utf8)!
        case .getBranches:
            return """
            [
                {
                "name": "master",
                "commit": {
                  "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
                  "url": "https://api.github.com/repos/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc"
                },
                "protected": true,
                "protection": {
                  "enabled": true,
                  "required_status_checks": {
                    "enforcement_level": "non_admins",
                    "contexts": [
                      "ci-test",
                      "linter"
                    ]
                  }
                },
                "protection_url": "https://api.github.com/repos/octocat/hello-world/branches/master/protection"
                }
            ]
            """.data(using: .utf8)!
        case .searchRespositories:
            return """
            {
              "total_count": 40,
              "incomplete_results": false,
              "items": [
                {
                  "id": 3081286,
                  "node_id": "MDEwOlJlcG9zaXRvcnkzMDgxMjg2",
                  "name": "Tetris",
                  "full_name": "dtrupenn/Tetris",
                  "owner": {
                    "login": "dtrupenn",
                    "id": 872147,
                    "node_id": "MDQ6VXNlcjg3MjE0Nw==",
                    "avatar_url": "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
                    "gravatar_id": "",
                    "url": "https://api.github.com/users/dtrupenn",
                    "received_events_url": "https://api.github.com/users/dtrupenn/received_events",
                    "type": "User"
                  },
                  "private": false,
                  "html_url": "https://github.com/dtrupenn/Tetris",
                  "description": "A C implementation of Tetris using Pennsim through LC4",
                  "fork": false,
                  "url": "https://api.github.com/repos/dtrupenn/Tetris",
                  "created_at": "2012-01-01T00:31:50Z",
                  "updated_at": "2013-01-05T17:58:47Z",
                  "pushed_at": "2012-01-01T00:37:02Z",
                  "homepage": "",
                  "size": 524,
                  "stargazers_count": 1,
                  "watchers_count": 1,
                  "language": "Assembly",
                  "forks_count": 0,
                  "open_issues_count": 0,
                  "master_branch": "master",
                  "default_branch": "master",
                  "score": 10.309712
                }
              ]
            }
            """.data(using: .utf8)!
        }
    }
    var headers: [String: String]? {
        return [
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
}
