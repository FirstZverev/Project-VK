//
//  OptionTwoTableViewCell.swift
//  WeatherApp
//
//  Created by Володя Зверев on 08.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

class OptionTwoTableViewCell: UITableViewCell {
    @IBOutlet weak var imageName: UIImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
