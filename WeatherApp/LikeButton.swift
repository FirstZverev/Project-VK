//
//  LikeButton.swift
//  WeatherApp
//
//  Created by Володя Зверев on 08.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit



class LikeButton: UIControl {
    
    var counter: Int = 10
    
    var isLiked: Bool = false {
        didSet {
            self.update()
            self.sendActions(for: .valueChanged)
        }
    }
    
    private weak var iconImageView: UIImageView?
    private weak var countLabel:    UILabel?
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setAppearance()
        self.addSubviews()
        self.addGestures()
        self.update()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setAppearance()
        self.addSubviews()
        self.addGestures()
        self.update()
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.iconImageView?.frame = CGRect(x: 0,
                                           y: 0,
                                           width: self.frame.size.width / 2,
                                           height: self.frame.size.height)
        
        self.countLabel?.frame = CGRect(x: self.frame.size.width / 2,
                                        y: 0,
                                        width: self.frame.size.width / 2,
                                        height: self.frame.size.height)
    }
    
    // MARK: - Actions
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        self.addGestureRecognizer(tapGesture)
        
        //        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        //        swipeLeftGesture.direction = [.left, .right]
        //        self.addGestureRecognizer(swipeLeftGesture)
    }
    
    @objc private func tapAction(tap: UITapGestureRecognizer) {
        
        print("\(tap.location(in: self).x) \(self.frame.size.width)")
        
        if tap.location(in: self).x < self.frame.size.width / 2 {
            self.isLiked = !self.isLiked
        }
        
        
    }
    
    @objc private func swipeAction(swipe: UISwipeGestureRecognizer) {
        if swipe.direction == .right && self.isLiked == false {
            self.isLiked = true
        } else if swipe.direction == .left && self.isLiked == true {
            self.isLiked = false
        }
    }
    
    // MARK: - Appearance
    
    private func setAppearance() {
        self.backgroundColor = UIColor.darkGray
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        self.addIconImageView()
        self.addCountLabel()
    }
    
    private func addIconImageView() {
        if nil != self.iconImageView {
            return
        }
        
        let iconImageView = UIImageView()
        self.addSubview(iconImageView)
        self.iconImageView = iconImageView
    }
    
    private func addCountLabel() {
        if nil != self.countLabel {
            return
        }
        
        let countLabel = UILabel()
        countLabel.textAlignment = .center
        countLabel.font = UIFont.systemFont(ofSize: 25)
        
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.minimumScaleFactor = 0.5
        
        self.addSubview(countLabel)
        self.countLabel = countLabel
    }
    
    // MARK: - Update
    
    private func update() {
        self.updateIconImageView()
        self.updateCountLabel()
    }
    
    private func updateIconImageView() {
        let imageName = self.isLiked ? "liked" : "unliked"
        let image = UIImage(named: imageName)
        self.iconImageView?.image = image
    }
    
    private func updateCountLabel() {
        let textColor = self.isLiked ? UIColor.black : UIColor.gray
        self.countLabel?.textColor = textColor
        
        if self.isLiked {
            self.counter += 1
        } else {
            self.counter -= 1
        }
        self.countLabel?.text = "\(self.counter)"
    }
}

