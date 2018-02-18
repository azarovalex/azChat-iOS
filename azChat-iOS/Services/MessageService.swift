//
//  MessageService.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 02/02/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    var messages = [Message]()
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            
            // Refactor the JSON unwrapping?
            // Maybe rewrite it with the Codable protocol??
            guard response.result.error == nil, let data = response.data, let jsonTmp = try? JSON(data: data).array, let json = jsonTmp else {
                completion(false)
                debugPrint(response.result.error as Any)
                return
            }
            
            for item in json {
                let name = item["name"].stringValue
                let description = item["description"].stringValue
                let id = item["_id"].stringValue
                let channel = Channel(channelTitle: name, channelDescription: description, id: id)
                self.channels.append(channel)
            }
            NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
            completion(true)
        }
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: bearerHeader).responseJSON { (response) in
            guard response.result.error == nil else {
                debugPrint(response.result.error as Any)
                completion(false)
                return
            }
            guard let data = response.data else { return }
            self.clearAllMessages()
            if let json = try! JSON(data: data).array {
                for item in json {
                    let messageBody = item["messageBody"].string
                    let channelId = item["channelId"].string
                    let id = item["_id"].string
                    let userName = item["userName"].string
                    let userAvatar = item["userAvatar"].string
                    let userAvatarColor = item["userAvatarColor"].string
                    let timeStamp = item["timeStamp"].string
                    
                    let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                    self.messages.append(message)
                }
                completion(true)
            }
        }
    }
    
    func clearAllMessages() {
        messages.removeAll()
    }
    
    func clearAllChannels() {
        channels.removeAll()
    }
}
