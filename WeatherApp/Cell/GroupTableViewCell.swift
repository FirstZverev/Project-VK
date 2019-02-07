//
//  GroupTableViewCell.swift
//  WeatherApp
//
//  Created by Володя Зверев on 07.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    @IBOutlet weak var labelGroup : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
