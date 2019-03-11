//
//  CMCommit.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 11/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import Foundation

struct CMCommit: Codable {
    
    let sha: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case sha
        case url
    }
    
}
