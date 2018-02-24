//
//  ChatVC.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 24/01/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessageBtn: UIButton!
    @IBOutlet weak var typingLbl: UILabel!
    
    // Variables
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        sendMessageBtn.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside )
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIF_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getChatMessages { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn {
                let verb = (numberOfTypers == 1) ? "is" : "are"
                self.typingLbl.text = "\(names) \(verb) typing..."
            } else {
                self.typingLbl.text = ""
            }
            
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_DATA_CHANGED, object: nil)
            })
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func userDataDidChanged(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        channelNameLbl.text = "#" + (MessageService.instance.selectedChannel?.channelTitle ?? "")
        getMessages()
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannels { (success) in
            guard success else { return }
            if MessageService.instance.channels.count > 0 {
                self.updateWithChannel()
            } else {
                self.channelNameLbl.text = "No channels yet!"
            }
        }
    }
    @IBAction func sendMessagePressed(_ sender: Any) {
        guard AuthService.instance.isLoggedIn,
            let channelId = MessageService.instance.selectedChannel?.id,
            let message = messageTxt.text else { return }
        
        SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
            if success {
                self.messageTxt.text = ""
                self.messageTxt.resignFirstResponder()
                SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        if messageTxt.text == "" {
            isTyping = false
            sendMessageBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if !isTyping {
                sendMessageBtn.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
