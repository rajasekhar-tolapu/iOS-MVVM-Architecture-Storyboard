//
//  AppHttpClient.swift
//  Clean MVVM Architecture
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation
import CoreData

class AppDataBaseClient {

    private let appDelegate: AppDelegate
    private let context: NSManagedObjectContext

    init(appDelegate: AppDelegate, context: NSManagedObjectContext) {
        self.appDelegate = appDelegate
        self.context = context
    }
}