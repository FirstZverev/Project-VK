//
//  Router.swift
//  WeatherApp
//
//  Created by Володя Зверев on 21.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit


enum OpenStyle {
    case segue
    case push
    case presentAnimated
    case presentAnimatedSimple
}




class Router: NSObject {
    
    var openStyle: OpenStyle = .presentAnimated
    
    let presentationDelegate = PresentationDelegate()
    let navigationDelegate   = NavigationDelegate()
    
    func openHints() {
        
        guard let viewController = self.getHintsViewController() else {
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        guard let navigationController = appDelegate.window?.rootViewController as? UINavigationController else {
            return
        }
        
        
        if self.openStyle == .segue, let loginViewController  = navigationController.viewControllers.first as? LoginFormController {
            loginViewController.performSegue(withIdentifier: "HintsSegue", sender: nil)
            return
        }
        
        
        if self.openStyle == .push {
            navigationController.delegate = self.navigationDelegate
            navigationController.pushViewController(viewController, animated: true)
            return
        }
        
        if self.openStyle == .presentAnimated {
            viewController.transitioningDelegate = self.presentationDelegate
            navigationController.present(viewController, animated: true, completion: nil)
            return
        }
        
        if self.openStyle == .presentAnimatedSimple {
            
            let transition = CATransition()
            transition.duration = 5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            
            navigationController.view.window?.layer.add(transition, forKey: kCATransition)
            navigationController.present(viewController, animated: false, completion: nil)
            return
        }
    }
    
    func closeHints(viewController: HintsViewController?) {
        
        
        if self.openStyle == .segue {
            viewController?.dismiss(animated: true, completion: nil)
            return
        }
        
        if self.openStyle == .push {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            guard let navigationController = appDelegate.window?.rootViewController as? UINavigationController else {
                return
            }
            
            navigationController.popViewController(animated: true)
            return
        }
        
        if self.openStyle == .presentAnimated {
            viewController?.dismiss(animated: true, completion: nil)
            return
        }
        
        if self.openStyle == .presentAnimatedSimple {
            let transition = CATransition()
            transition.duration = 5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            viewController?.view.window?.layer.add(transition, forKey: kCATransition)
            viewController?.dismiss(animated: false, completion: nil)
            
            return
        }
    }
    
    
    // MARK: -
    
    private func getHintsViewController() -> HintsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "HintsViewController") as? HintsViewController else {
            return nil
        }
        
        viewController.transitioningDelegate = self.presentationDelegate
        
        return viewController
    }
}
