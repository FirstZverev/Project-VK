//
//  VkView.swift
//  WeatherApp
//
//  Created by Володя Зверев on 10/07/2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftKeychainWrapper


class VkResponse: Mappable {
    var response: VkResponseInterval? = nil
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}
class VkResponseInterval: Mappable {
    var items: [Groups] = []
    
    required init?(map: Map) {}
    
     func mapping(map: Map) {
        items <- map["items"]
    }
    

}

class VkViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KeychainWrapper.standard.set("3e4c77bc7d774a61c745696e6d473af7675abb2b3fae610c216bc24bd54bf4e7436f8fea814ff52b9940b", forKey: "token")
        let tokenVK = KeychainWrapper.standard.string(forKey: "token")
        AF.request("https://api.vk.com/method/groups.get?extended=1&access_token=3e4c77bc7d774a61c745696e6d473af7675abb2b3fae610c216bc24bd54bf4e7436f8fea814ff52b9940b&v=5.95").responseObject(completionHandler: { (vkResponse: DataResponse<VkResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let val): print(val.response?.items)
            case .failure(let error): print(error)
            }
        })
        
    }
        
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        print(token)
        AF.request("https://api.vk.com/method/groups.get?extended=1&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print("СООБЩЕСТВА ПОЛЬЗОВАТЕЛЯ")
            print(response.value)
            let tokenConst = "3e4c77bc7d774a61c745696e6d473af7675abb2b3fae610c216bc24bd54bf4e7436f8fea814ff52b9940b"
        }
//
//        AF.request("https://api.vk.com/method/groups.search?q=music&access_token=\(token!)&v=5.95").responseJSON { (response) in
//            print("ПОИСК СООБЩЕСТВ")
//            print(response.value)
//        }
//        AF.request("https://api.vk.com/method/friends.get?&access_token=\(token!)&v=5.95").responseJSON { (response) in
//            print("ДРУЗЬЯ ПОЛЬЗОВАТЕЛЯ")
//            print(response.value)
//        }
//        AF.request("https://api.vk.com/method/photos.getAll?&access_token=\(token!)&v=5.95").responseJSON { (response) in
//            print("ФОТОГРАФИИ ПОЛЬЗОВАТЕЛЯ")
//            print(response.value)
//        }

        decisionHandler(.cancel)
    }
    
    func logoutVK() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            dataStore.removeData(
                ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
                for: records.filter { $0.displayName.contains("vk")},
                completionHandler: { }
            )
        }
        
    }
    
}

