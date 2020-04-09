//
//  DatabasebaseHelper.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation

protocol DatabaseHelper {
}

class DatabaseHelperImpl: DatabaseHelper {
    static var shared: DatabaseHelper = DatabaseHelperImpl()
}
