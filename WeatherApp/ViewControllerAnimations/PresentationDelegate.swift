//
//  PresentationDelegate.swift
//  WeatherApp
//
//  Created by Stanislav Ivanov on 19/02/2019.
//  Copyright © 2019 Stanislav Ivanov. All rights reserved.
//

import UIKit


class PresentationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let openAnimationController  = OpenAnimationController(isPresented: true)
    let closeAnimationController = CloseAnimationController(isPresented: true)
    
    let interactiveClose = InteractiveClose()
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactiveClose.hasStarted ? self.interactiveClose : nil
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.interactiveClose.viewController = presented
        return self.openAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self.closeAnimationController
    }
}
