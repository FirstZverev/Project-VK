//
//  HintsSegue.swift
//  WeatherApp
//
//  Created by Stanislav Ivanov on 19/02/2019.
//  Copyright © 2019 Stanislav Ivanov. All rights reserved.
//

import UIKit

class HintsSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let fromVC = self.source
        let toVC   = self.destination
        
        
        var hintsButtonFrame: CGRect = CGRect.zero
        if let loginViewController = fromVC as? FeedTableViewController,
            let hintsButton = loginViewController.hintsButton {
            hintsButtonFrame = hintsButton.frame
        } else if let navViewController = fromVC as? UINavigationController,
            let loginViewController = navViewController.viewControllers.first as? FeedTableViewController,
            let hintsButton = loginViewController.hintsButton {
            hintsButtonFrame = hintsButton.frame
        }
        
        fromVC.view.superview?.addSubview(toVC.view)
        toVC.view.frame = hintsButtonFrame
        
        UIView.animate(withDuration: 3,
                       animations: {
                        toVC.view.frame = fromVC.view.bounds
        }) { (finished: Bool) in
            
            fromVC.present(toVC, animated: false, completion: nil)
        }
    }
}
