//
//  SocketService.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 2/6/18.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = SocketManager(socketURL: URL(string: URL_BASE)!).defaultSocket
    
    func establichConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}
