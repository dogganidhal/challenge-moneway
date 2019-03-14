//
//  CMBranch.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 11/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation

struct CMBranch: Codable {
    
    let name: String
    let commit: CMCommit
    let protected: Bool
    let protection: CMPBranchProtection?
    let protectionUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case commit
        case protected
        case protection
        case protectionUrl = "protection_url"
    }
 
}
