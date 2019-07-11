//
//  VkService.swift
//  WeatherApp
//
//  Created by Володя Зверев on 11/07/2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class VkService {
    func requestGroups(completion: ([Groups]) ->Void) {
        AF.request("https://api.vk.com/method/groups.get?extended=1&access_token=3e4c77bc7d774a61c745696e6d473af7675abb2b3fae610c216bc24bd54bf4e7436f8fea814ff52b9940b&v=5.95").responseObject(completionHandler: { (vkResponse: DataResponse<VkResponse>) in
            let result = vkResponse.result
            switch result {
            case .success(let val): print(val.response?.items)
            case .failure(let error): print(error)
            }
        })
    }
}
