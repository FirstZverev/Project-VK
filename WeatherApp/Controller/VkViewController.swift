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

class VkViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        logoutVK()
                //MARK: - VK Into
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7051075"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                    URLQueryItem(name: "scope", value: "262150"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
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
        AF.request("https://api.vk.com/method/groups.get?&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print("СООБЩЕСТВА ПОЛЬЗОВАТЕЛЯ")
            print(response.value)
        }

        AF.request("https://api.vk.com/method/groups.search?q=music&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print("ПОИСК СООБЩЕСТВ")
            print(response.value)
        }
        AF.request("https://api.vk.com/method/friends.get?&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print("ДРУЗЬЯ ПОЛЬЗОВАТЕЛЯ")
            print(response.value)
        }
        AF.request("https://api.vk.com/method/photos.getAll?&access_token=\(token!)&v=5.95").responseJSON { (response) in
            print("ФОТОГРАФИИ ПОЛЬЗОВАТЕЛЯ")
            print(response.value)
        }

        
        
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

