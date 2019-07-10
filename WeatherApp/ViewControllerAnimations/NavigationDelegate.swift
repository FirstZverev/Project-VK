//
//  NavigationDelegate.swift
//  WeatherApp
//
//  Created by Stanislav Ivanov on 19/02/2019.
//  Copyright © 2019 Stanislav Ivanov. All rights reserved.
//

import UIKit

class NavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    let openAnimationController  = OpenAnimationController(isPresented: false)
    let closeAnimationController = CloseAnimationController(isPresented: false)
    let interactiveClose = InteractiveClose()
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var controller: UIViewControllerAnimatedTransitioning?
        
        switch operation {
        case .none:
            break
        case .push:
            self.interactiveClose.viewController = toVC
            controller = self.openAnimationController
        case .pop:
            self.interactiveClose.viewController = toVC
            controller = self.closeAnimationController
        }
        
        return controller
    }
}
