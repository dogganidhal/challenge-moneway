//
//  CMContributorCell.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class CMContributorCell: UITableViewCell {

    @IBOutlet weak var contributorNameLabel: UILabel!
    @IBOutlet weak var contributorPhotoImageView: UIImageView!
    
    static let reuseIdentifier: String = "CMContributorCell"
    
    var contributor: CMContributor? {
        didSet {
            self.contributorNameLabel.text = self.contributor?.login
            
        }
    }
    
}
