//
//  DataHelper.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation

class DataHelper {
    static var shared: DataHelper = DataHelper(cacheHelper: CacheHelperImpl.shared, apiHelper: ApiHelperImpl.shared,
            databaseHelper: DatabaseHelperImpl.shared, storageHelper: StorageHelperImpl.shared)

    let cacheHelper: CacheHelper
    let apiHelper: ApiHelper
    let databaseHelper: DatabaseHelper
    let storageHelper: StorageHelper

    // Private Constructor so that no one can instantiate DataHelper
    private init(cacheHelper: CacheHelper, apiHelper: ApiHelper, databaseHelper: DatabaseHelper,
                 storageHelper: StorageHelper) {
        self.cacheHelper = cacheHelper
        self.apiHelper = apiHelper
        self.databaseHelper = databaseHelper
        self.storageHelper = storageHelper
    }
}
