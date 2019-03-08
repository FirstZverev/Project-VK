//
//  InteractiveClose.swift
//  WeatherApp
//
//  Created by Stanislav Ivanov on 19/02/2019.
//  Copyright © 2019 Stanislav Ivanov. All rights reserved.
//


import UIKit



class InteractiveClose: UIPercentDrivenInteractiveTransition {
    
    var viewController: UIViewController? {
        didSet {
            //            let screenPan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenPan(pan:)))
            //            screenPan.edges = [.left]
            //            self.viewController?.view.addGestureRecognizer(screenPan)
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handleScreenPan(pan:)))
            self.viewController?.view.addGestureRecognizer(pan)
        }
    }
    
    var hasStarted:   Bool = false
    var shouldFinish: Bool = false
    
    @objc func handleScreenPan(pan: UIPanGestureRecognizer) {
        
        switch pan.state {
        case .began:
            print("began")
            self.hasStarted = true
            self.viewController?.dismiss(animated: true, completion: nil)
            break
        case .cancelled:
            print("cancelled")
            self.hasStarted = false
            self.cancel()
            break
        case .ended:
            print("ended shouldFinish \(self.shouldFinish)")
            self.hasStarted = false
            self.shouldFinish ? self.finish() : self.cancel()
            break
        case .changed:
            let translation = pan.translation(in: pan.view?.superview)
            let relativeTranslation = translation.y / (pan.view?.superview?.bounds.height ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            self.shouldFinish = progress > 0.33
            self.update(progress)
            break
            
        case .possible:
            print("changed")
            break
        case .failed:
            print("failed")
            break
        }
    }
}
