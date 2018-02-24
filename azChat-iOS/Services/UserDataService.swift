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
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
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
    
    func returnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "[], ")
        
        var r, g, b, a: NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        guard let rUnwrapped = r, let gUnwrapped = g, let bUnwrapped = b, let aUnwrapped = a else {
            return UIColor.lightGray
        }
        
        return UIColor(red: CGFloat(rUnwrapped.doubleValue), green: CGFloat(gUnwrapped.doubleValue), blue: CGFloat(bUnwrapped.doubleValue), alpha: CGFloat(aUnwrapped.doubleValue))
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = ""
        MessageService.instance.clearAllChannels()
        MessageService.instance.clearAllMessages()
    }
}
