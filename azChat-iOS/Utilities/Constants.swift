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
let URL_BASE = "https://az-chat.herokuapp.com/v1/"
let URL_REGISTER = URL_BASE + "account/register"
let URL_LOGIN = URL_BASE + "account/login"
let URL_USER_ADD = URL_BASE + "user/add"
let URL_USER_BY_EMAIL = "\(URL_BASE)user/byEmail/"
let URL_GET_CHANNELS = "\(URL_BASE)channel/"

// Notification
let NOTIF_DATA_CHANGED = Notification.Name("notifDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name(rawValue: "notifChannelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name(rawValue: "notifChannelSelected")

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
