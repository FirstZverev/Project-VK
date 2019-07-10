//
//  Loader.swift
//  WeatherApp
//
//  Created by Stanislav Ivanov on 12/02/2019.
//  Copyright © 2019 Stanislav Ivanov. All rights reserved.
//


import UIKit



enum LoaderAnimationStep {
    case step1
    case step2
    case step3
    case stepEnd
}



class Loader: UIView {
    
    @IBOutlet weak var labelThree: UILabel?
    @IBOutlet weak var labelTwo: UILabel?
    @IBOutlet weak var label: UILabel?
    
    var animationStep: LoaderAnimationStep = .step1 {
        didSet {
            self.updateStep()
        }
    }
    
    let animationaDuration: TimeInterval = 1
    
    private var isLoading: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    func customInit() {
        let label = UILabel()
        
        self.addSubview(label)
        //        self.label = label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        self.label?.frame = self.bounds
    }
    
    
    func start() {
        self.isHidden  = false
        self.isLoading = true
        self.updateStep()
    }
    
    func stop() {
        self.isHidden  = true
        self.isLoading = false
    }
    
    func updateStep() {
        print("\(self.label)")
        print("\(self.labelTwo)")
        print("\(self.labelThree)")
        
        if false == self.isLoading {
            return
        }
        
        switch self.animationStep {
        case .step1:
            self.animateStep1()
        case .step2:
            self.animateStep2()
        case .step3:
            self.animateStep3()
        case .stepEnd:
            self.animateStepEnd()
        }
    }
    
    func animateStep1() {
        UIView.animate(withDuration: self.animationaDuration,
                       animations: {
                        self.label?.alpha = 0
                        self.labelTwo?.alpha = 0.5
                        self.labelThree?.alpha = 1
        }) { (finished: Bool) in
            self.animationStep = .step2
        }
    }
    
    func animateStep2() {
        UIView.animate(withDuration: self.animationaDuration,
                       animations: {
                        self.label?.alpha = 0.5
                        self.labelTwo?.alpha = 0
                        self.labelThree?.alpha = 0.5
                        
        }) { (finished: Bool) in
            self.animationStep = .step3
        }
    }
    
    func animateStep3() {
        UIView.animate(withDuration: self.animationaDuration,
                       animations: {
                        self.label?.alpha = 1
                        self.labelTwo?.alpha = 0.5
                        self.labelThree?.alpha = 0
                        
        }) { (finished: Bool) in
            self.animationStep = .stepEnd
        }
    }
    
    func animateStepEnd() {
        UIView.animate(withDuration: self.animationaDuration,
                       animations: {
                        self.label?.alpha = 0.5
                        self.labelTwo?.alpha = 0
                        self.labelThree?.alpha = 0.5
                        
        }) { (finished: Bool) in
            self.animationStep = .step1
        }
    }
}
