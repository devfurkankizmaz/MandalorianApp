//
//  Login.swift
//  MandalorianApp
//
//  Created by Furkan Kızmaz on 17.08.2023.
//

import Foundation

struct Login: Codable {
    var email: String
    var password: String
}

struct LoginResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
