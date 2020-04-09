//
//  AppHttpClient.swift
//  Clean MVVM Architecture
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation

class AppCacheClient {
    private let userDefault: UserDefaults

    init(_ userDefaults: UserDefaults) {
        self.userDefault = userDefaults
    }

    func putInt(key: String, value: Int?) {
        putAny(key: key, value: value)
    }

    func putString(key: String, value: String?) {
        putAny(key: key, value: value)
    }

    func putBoolean(key: String, value: Bool?) {
        putAny(key: key, value: value)
    }

    func putDouble(key: String, value: Double?) {
        putAny(key: key, value: value)
    }

    func putData<T: Codable>(key: String, value: T?) throws {
        putAny(key: key, value: try? JSONEncoder().encode(value))
    }

    private func putAny(key: String, value: Any?) {
        userDefault.set(value, forKey: key)
        userDefault.synchronize()
    }

    func getInt(key: String) -> Int? {
        return userDefault.integer(forKey: key)
    }

    func getString(key: String) -> String? {
        return userDefault.string(forKey: key)
    }

    func getDouble(key: String) -> Double? {
        return userDefault.double(forKey: key)
    }

    func getBoolean(key: String) -> Bool? {
        return userDefault.bool(forKey: key)
    }

    private func getAny(key: String) -> Any? {
        return userDefault.value(forKey: key)
    }

    func getData<T: Codable>(key: String) -> T? {
        if getAny(key: key) == nil {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: getAny(key: key) as! Data)
    }
}