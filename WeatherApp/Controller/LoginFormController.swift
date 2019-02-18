//
//  LoginFormController.swift
//  WeatherApp
//
//  Created by Володя Зверев on 25.01.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var vkLabelName: UILabel?
    
    @IBOutlet weak var hintLabel: UILabel?
    @IBOutlet weak var stackView: UIStackView?
    @IBOutlet weak var hintLabelTopConstraint: NSLayoutConstraint?
    @IBOutlet weak var hintLabelWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var hintLabelHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var loader: Loader?

    @IBAction func logoutAction(segue: UIStoryboardSegue?) {
        self.scrollView?.alpha = 0
    }

    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loader?.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.loader?.stop()
            self.loaderStopped()
        })
    }
    func loaderStopped() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
                        
//                        self.hintLabel?.frame.origin.y = self.view.frame.size.height
//
//                        self.hintLabelTopConstraint?.constant = self.view.frame.size.height
                        self.view.layoutIfNeeded()
                        
        }) { (finished: Bool) in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.scrollView?.alpha = 1
//                self.animateTitleAppearing()
//                self.vkLabelName?.frame.origin.x =
            }, completion: { (finished: Bool) in
//                self.animateShadow()
            })
        }
    }
//    func animateTitleAppearing() {
//        self.vkLabelName?.transform = CGAffineTransform(translationX: 0,
//                                                     y: -self.view.bounds.height/2)
//
//        UIView.animate(withDuration: 1,
//                       delay: 1,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: .curveEaseOut,
//                       animations: {
//                        self.vkLabelName?.transform = .identity
//        },
//                       completion: nil)
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе -- когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView?.alpha = 0
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        // Получаем текст логина
        let login = loginInput.text!
        // Получаем текст-пароль
        let password = passwordInput.text!
        
        // Проверяем, верны ли они
        if login == "" && password == "" {
            print("Успешная авторизация")
            self.performSegue(withIdentifier: "openApp", sender: nil)
        } else {
            print("Неуспешная авторизация")
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


