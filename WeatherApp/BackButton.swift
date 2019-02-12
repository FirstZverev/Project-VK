//
//  BackButton.swift
//  WeatherApp
//
//  Created by Володя Зверев on 08.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit


@IBDesignable class UserpicView: UIView {
    
    private weak var imageView: UIImageView?
    
    @IBInspectable var imageName: String = "userpic" {
        didSet {
            self.addSubviews()
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.imageView?.image = UIImage(named: imageName)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            //self.setShadow()
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAppearance()
        self.addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setAppearance()
        self.addSubviews()
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = self.bounds
        self.imageView?.layer.cornerRadius = self.frame.size.height / 2
        self.imageView?.layer.masksToBounds = true
        
        
    }
    
    // MARK: - Appearance
    
    private func setAppearance() {
        self.backgroundColor = nil
        
        self.setShadow()
    }
    
    private func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOffset = CGSize(width: 0, height: self.shadowRadius)
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        if nil == self.imageView {
            let imageView = UIImageView(image: UIImage(named: "userpic"))
            self.addSubview(imageView)
            self.imageView = imageView
        }
    }
}
