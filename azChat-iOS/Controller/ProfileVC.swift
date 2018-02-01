//
//  ProfileVC.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 01/02/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_DATA_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setUpView() {
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        usernameTxt.text = UserDataService.instance.name
        emailTxt.text = UserDataService.instance.email
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
