//
//  CMBranchCell.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import UIKit

class CMBranchCell: UITableViewCell {

    @IBOutlet weak var branchNameLabel: UILabel!
    
    static let reuseIdentifier: String = "CMBranchCell"
    
    var branch: CMBranch? {
        didSet {
            self.branchNameLabel.text = branch?.name
        }
    }
    
}
