//
//  CircleImage.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 31/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    override func awakeFromNib() {
        setUpView()
    }

    func setUpView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
}
