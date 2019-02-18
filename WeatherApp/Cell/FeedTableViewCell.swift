//
//  FeedTableViewCell.swift
//  WeatherApp
//
//  Created by Володя Зверев on 08.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var photoFeed: UIImageView?
    var i = 0
    var j = 0
    @IBAction func buttonClick(){
        i += 1
        print("Начала нажатия:\(i)")
        UIView.animate(withDuration: 0.3, animations: {
            self.photoFeed?.frame = CGRect (x: 51, y: 60, width: 280, height: 180)
        })
    }
    @IBAction func buttonClickCancel(){
        j += 1
        print("Конец нажатия:\(j)")
        UIView.animate(withDuration: 0.3, animations: {
        self.photoFeed?.frame = CGRect (x: 41, y: 50, width: 300, height: 200)
        })
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        self.photoFeed?.alpha = 1
    }
}
