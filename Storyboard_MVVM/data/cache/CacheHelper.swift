//
//  CacheHelper.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation

class CacheKeys {
    static let accessToken = "x-access-token"
    static let userId = "x-user-id"
    static let userRole = "x-user-role"
}

protocol CacheHelper {
}

class CacheHelperImpl: CacheHelper {
    static var shared: CacheHelper = CacheHelperImpl()
}
