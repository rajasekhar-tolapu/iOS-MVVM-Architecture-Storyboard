//
//  SignUp.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 12/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation

// SignUpRequest
struct SignUpRequest: Codable {
    let name, email, password, profilePicUrl: String

    init(name: String, email: String, password: String, profilePicUrl: String) {
        self.name = name
        self.email = email
        self.password = password
        self.profilePicUrl = profilePicUrl
    }

    enum CodingKeys: String, CodingKey {
        case name, email, password, profilePicUrl
    }
}

// SignUpResponse
struct SignUpResponse: Codable {
    let statusCode, message: String
    let data: DataClass
}

struct DataClass: Codable {
    let user: User
    let tokens: Tokens
}

struct Tokens: Codable {
    let accessToken, refreshToken: String
}

struct User: Codable {
    let id, name, email: String
    let roles: [String]
    let profilePicURL: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, roles
        case profilePicURL = "profilePicUrl"
    }
}
