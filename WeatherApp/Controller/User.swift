//
//  User.swift
//  WeatherApp
//
//  Created by Володя Зверев on 11/07/2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var id: Int = 0
    var photo: String = ""
    var name: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        photo <- map["photo_50"]
        name <- map["name"]
    }
}
