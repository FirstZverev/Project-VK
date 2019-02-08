//
//  Image.swift
//  WeatherApp
//
//  Created by Володя Зверев on 08.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

class Image: UIImageView {

    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.cornerRadius = 50
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize.zero
        layer.masksToBounds = true


    }
}
