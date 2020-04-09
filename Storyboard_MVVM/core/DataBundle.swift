//
//  Data.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation

class DataBundle {
    private var data = [String: Any]()
    var isEmpty: Bool {
        return data.count <= 0
    }

    var count: Int {
        return data.count
    }

    func putInt(key: String, value: Int) {
        data[key] = value
    }

    func putString(key: String, value: String) {
        putAny(key: key, value: value)
    }

    func putBoolean(key: String, value: Bool) {
        putAny(key: key, value: value)
    }

    func putDouble(key: String, value: Double) {
        putAny(key: key, value: value)
    }

    func putData<T: Codable>(key: String, value: T) {
        putAny(key: key, value: try! JSONEncoder().encode(value))
    }

    private func putAny(key: String, value: Any) {
        data[key] = value
    }

    func getInt(key: String) -> Int? {
        return data[key] as? Int
    }

    func getString(key: String) -> String? {
        return data[key] as? String
    }

    func getDouble(key: String) -> Double? {
        return data[key] as? Double
    }

    func getBoolean(key: String) -> Bool? {
        return data[key] as? Bool
    }

    func getData<T: Codable>(key: String) -> T? {
        return try? JSONDecoder().decode(T.self, from: data[key] as! Data)
    }
}
