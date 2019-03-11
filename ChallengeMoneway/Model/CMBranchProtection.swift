//
//  CMBranchProtection.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 11/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation

struct CMPBranchProtection: Codable {
    
    struct CMBranchProtectionStatusChecks: Codable {
        
        let renforcementLevel: String
        let contexts: [String]
        
        enum CodingKeys: String, CodingKey {
            case renforcementLevel = "renforcement_level"
            case contexts
        }
        
    }
    
    let protected: Bool
    let protection: CMBranchProtectionStatusChecks
    
    enum CodingKeys: String, CodingKey {
        case protected
        case protection
    }
    
}
