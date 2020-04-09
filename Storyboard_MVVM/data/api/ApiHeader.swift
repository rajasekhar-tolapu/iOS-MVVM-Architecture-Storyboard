//
//  ApiHeader.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 12/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation
import Alamofire

class ApiHeaders {

    func publicApiHeaders() -> HTTPHeaders {
        return ["Content-Type": "application/json", "x-api-key": Environment.apiKey, ]
    }

    func protectedApiHeaders() -> HTTPHeaders {
        return ["Content-Type": "application/json",
                "x-api-key": Environment.apiKey,
                "x-user-id": UserDefaults.standard.string(forKey: CacheKeys.userId) ?? "",
                "x-access-token": UserDefaults.standard.string(forKey: CacheKeys.accessToken) ?? ""]
    }

    func customApiHeaders(_ headers: HTTPHeaders) -> HTTPHeaders {
        var map: [String: String] = [:]
        map["Content-Type"] = "application/json"
        map["x-api-key"] = Environment.apiKey
        headers.forEach { (key, value) in
            map[key] = value
        }
        return map
    }
}
