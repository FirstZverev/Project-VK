//
//  LoginAPIManager.swift
//  WeatherApp
//
//  Created by Володя Зверев on 08.03.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import Foundation

protocol LoginAPIProtocol: class {
    
}
class UserInfo {
    //
}
class SessionInfo {
    //
}

class LoginAPIManager {
    private init() {}
    static let shared : LoginAPIProtocol = FakeAPIManager()
    var UserInfo: UserInfo?
    var SessionInfo: SessionInfo?
}

private class FakeAPIManager: LoginAPIProtocol {
        func logIn(login: String, password: String, completion: @escaping (Error?) -> ()) {
        
        print("LoginAPIManager")
        print("  login \(login)")
        print("  password \(password)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            print("  completion")
            completion(nil)
        })
    }
}
