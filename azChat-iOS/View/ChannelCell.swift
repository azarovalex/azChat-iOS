//
//  ChannelCell.swift
//  azChat-iOS
//
//  Created by Alex Azarov on 03/02/2018.
//  Copyright © 2018 Alex Azarov. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var channelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        channelTitle.text = "#" + title
        channelTitle.font = UIFont(name: "Avenir", size: 17)
        if MessageService.instance.unreadChannels.contains(channel.id) {
            channelTitle.font = UIFont(name: "Avenir-Bold", size: 25)
        }
    }
}
