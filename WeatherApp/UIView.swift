//
//  UIView.swift
//  WeatherApp
//
//  Created by Володя Зверев on 08.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

@IBDesignable class TestView: UIView {
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        //    let testView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
        layer.cornerRadius = 50
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize.zero
        
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
