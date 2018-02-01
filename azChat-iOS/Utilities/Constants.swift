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
let BASE_URL = "https://az-chat.herokuapp.com/v1/"
let REGISTER_URL = BASE_URL + "account/register"
let LOGIN_URL = BASE_URL + "account/login"
let USER_ADD_URL = BASE_URL + "user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"

// Notification
let NOTIF_DATA_CHANGED = Notification.Name("notifDataChanged")

// Colors
let placeholderColor = #colorLiteral(red: 0, green: 0.2684682608, blue: 0.4762560725, alpha: 0.5)

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwinedToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
