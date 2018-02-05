//
//  AddChannelVC.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 2/5/18.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    // Outlets
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var channelDescTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
    }
    
    func setUpView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "Channel name", attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
        channelDescTxt.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])

    }
    
    @objc func closeTap() {
        dismiss(animated: true, completion: nil)
    }
}
