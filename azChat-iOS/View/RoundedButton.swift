//
//  RoundedButton.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 26/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            updateCornerRadius(cornerRadius)
        }
    }
    
    override func awakeFromNib() {
        updateCornerRadius(cornerRadius)
    } 
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateCornerRadius(cornerRadius)
    }
    
    func updateCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}
