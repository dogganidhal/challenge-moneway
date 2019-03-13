//
//  CMRepositoryCell.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 13/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import UIKit

class CMRepositoryCell: UITableViewCell {

    static let reuseIdentifier: String = "CMRepositoryCellIdentifier"
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    var repository: CMGithubRepository? {
        didSet {
            self.repositoryNameLabel?.text = self.repository?.fullName
            self.repositoryDescriptionLabel?.text = self.repository?.description
            self.languageLabel.text = self.repository?.language
            self.starCountLabel.text = "\(self.repository?.stargazersCount ?? 0)"
        }
    }
    
}
