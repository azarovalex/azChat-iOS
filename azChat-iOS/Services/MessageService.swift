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
            completion(true)
        }
    }
    
    func clearAllMesagges() {
        channels.removeAll()
    }
}
