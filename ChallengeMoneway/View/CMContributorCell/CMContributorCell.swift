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
import PINRemoteImage

class CMContributorCell: UITableViewCell {

    @IBOutlet weak var contributorNameLabel: UILabel!
    @IBOutlet weak var contributorPhotoImageView: UIImageView!
    
    static let reuseIdentifier: String = "CMContributorCell"
    
    var contributor: CMContributor? {
        didSet {
            if let contributor = self.contributor {
                self.contributorNameLabel.text = contributor.login
                self.contributorPhotoImageView.pin_setImage(from: URL(string: contributor.avatarUrl))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupImageView()
    }
    
    private func setupImageView() {
        self.contributorPhotoImageView.layer.masksToBounds = true
        self.contributorPhotoImageView.layer.cornerRadius = 32
    }
    
}
