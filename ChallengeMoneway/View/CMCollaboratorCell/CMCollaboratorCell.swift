//
//  CMCollaboratorCell.swift
//  ChallengeMoneway
//
//  Created by Nidhal DOGGA on 14/03/2019.
//  Copyright © 2019 Nidhal DOGGA. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class CMCollaboratorCell: UITableViewCell {

    @IBOutlet weak var collaboratorNameLabel: UILabel!
    @IBOutlet weak var collaboratorPhotoImageView: UIImageView!
    
    static let reuseIdentifier: String = "CMCollaboratorCell"
    
    var collaborator: CMCollaborator? {
        didSet {
            self.collaboratorNameLabel.text = self.collaborator?.login
            
        }
    }
    
}
