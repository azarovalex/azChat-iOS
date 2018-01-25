//
//  CreateAccountVC.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 25/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwinedToChannel", sender: nil)
    }
    
    
}
