//
//  AvatarCell.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 30/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
//        self.clipsToBounds = true
    }
}
