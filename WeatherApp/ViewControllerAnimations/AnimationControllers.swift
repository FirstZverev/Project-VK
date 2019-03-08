//
//  AnimationControllers.swift
//  WeatherApp
//
//  Created by Stanislav Ivanov on 19/02/2019.
//  Copyright © 2019 Stanislav Ivanov. All rights reserved.
//

import UIKit


let animationDuration: TimeInterval = 0.5



class CloseAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresented: Bool = true
    
    init(isPresented: Bool) {
        super.init()
        self.isPresented = isPresented
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        var hintsButtonFrame: CGRect = CGRect.zero
        if let loginViewController = toVC as? FeedTableViewController,
            let hintsButton = loginViewController.hintsButton {
            hintsButtonFrame = hintsButton.frame
        } else if let navViewController = toVC as? UINavigationController,
            let loginViewController = navViewController.viewControllers.first as? FeedTableViewController,
            let hintsButton = loginViewController.hintsButton {
            hintsButtonFrame = hintsButton.frame
        }
        
        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        toVC.view.frame = fromVC.view.bounds
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        fromVC.view.frame = hintsButtonFrame
        }) { (finished: Bool) in
            
            fromVC.removeFromParent()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}


class OpenAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresented: Bool = true
    
    init(isPresented: Bool) {
        super.init()
        self.isPresented = isPresented
    }
    
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        var hintsButtonFrame: CGRect = CGRect.zero
        if let loginViewController = fromVC as? FeedTableViewController,
            let hintsButton = loginViewController.hintsButton {
            hintsButtonFrame = hintsButton.frame
        } else if let navViewController = fromVC as? UINavigationController,
            let loginViewController = navViewController.viewControllers.first as? FeedTableViewController,
            let hintsButton = loginViewController.hintsButton {
            hintsButtonFrame = hintsButton.frame
        }
        
        transitionContext.containerView.addSubview(toVC.view)
        toVC.view.frame = hintsButtonFrame
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        toVC.view.frame = fromVC.view.bounds
        }) { (finished: Bool) in
            
            if self.isPresented {
                fromVC.removeFromParent()
            } else {
                fromVC.view.removeFromSuperview()
            }
            
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
