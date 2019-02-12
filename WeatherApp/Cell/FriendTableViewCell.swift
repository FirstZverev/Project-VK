//
//  FriendTableViewCell.swift
//  WeatherApp
//
//  Created by Володя Зверев on 05.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var labelPrototip : UILabel!
    @IBOutlet weak var ImageFriend: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

