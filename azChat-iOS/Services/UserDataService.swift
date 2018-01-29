//
//  UserDataService.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 29/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    private private(set) var id = ""
    private private(set) var avatarColor = ""
    private private(set) var avatarName = ""
    private private(set) var email = ""
    private private(set) var name = ""
    
    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
}
