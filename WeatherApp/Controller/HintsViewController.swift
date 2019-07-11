//
//  HintsViewController.swift
//  WeatherApp
//
//  Created by Володя Зверев on 21.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit


class HintsViewController: UIViewController {

    var imageHintsFeed = ""
    let router = Router()
    @IBOutlet weak var ImageFeed: UIImageView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(closeBySwipe))
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
    }
    override func viewDidAppear(_ animated: Bool) {
        ImageFeed?.image = UIImage(named: imageHintsFeed)
    }
    @objc func closeBySwipe() {
        self.router.closeHints(viewController: self)
    }
    
        //cell.ImageFeed?.image = UIImage(named: self.imageNameFeed)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
