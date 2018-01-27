//
//  Constants.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 25/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success: Bool) -> Void

// URL Constants
// let BASE_URL = "http://localhost:3005/v1/"
let BASE_URL = "https://az-chat.herokuapp.com/v1/"
let REGISTER_URL = BASE_URL + "account/register"
let LOGIN_URL = BASE_URL + "account/login"

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwinedToChannel"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
