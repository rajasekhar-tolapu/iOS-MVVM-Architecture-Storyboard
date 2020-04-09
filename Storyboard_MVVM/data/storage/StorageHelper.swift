//
//  StorageHelper.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation

protocol StorageHelper {
}

class StorageHelperImpl: StorageHelper {
    static var shared: StorageHelper = StorageHelperImpl()
}
