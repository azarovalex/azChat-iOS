//
//  AuthService.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 26/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//Constants
let header = [
    "Content-Type": "application/json; charset=utf-8"
]
let bearerHeader = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.string(forKey: TOKEN_KEY)!
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.string(forKey: USER_EMAIL)!
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let body: [String: Any] = [
            "email": email.lowercased(),
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            guard response.result.error == nil else {
                completion(false)
                debugPrint(response.result.error as Any)
                return
            }
            completion(true)
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let body: [String: Any] = [
            "email": email.lowercased(),
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            guard response.result.error == nil, let data = response.data, let json = try? JSON(data: data) else {
                completion(false)
                debugPrint(response.result.error as Any)
                return
            }
            
            self.authToken = json["token"].stringValue
            self.userEmail = json["user"].stringValue
            self.isLoggedIn = true
            
            completion(true)
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        let body: [String: Any] = [
            "email": email.lowercased(),
            "name": name,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            guard response.result.error == nil, let data = response.data, let json = try? JSON(data: data) else {
                completion(false)
                debugPrint(response.result.error as Any)
                return
            }
            
            UserDataService.instance.setUserData(id: json["_id"].stringValue, avatarColor: json["avatarColor"].stringValue, avatarName: json["avatarName"].stringValue, email: json["email"].stringValue, name: json["name"].stringValue)
            completion(true)
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            guard response.result.error == nil, let data = response.data, let json = try? JSON(data: data) else {
                completion(false)
                debugPrint(response.result.error as Any)
                return
            }
            
            UserDataService.instance.setUserData(id: json["_id"].stringValue, avatarColor: json["avatarColor"].stringValue, avatarName: json["avatarName"].stringValue, email: json["email"].stringValue, name: json["name"].stringValue)
            completion(true)
        }
    }
}








