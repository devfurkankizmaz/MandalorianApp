import Foundation

struct Register: Codable {
    var full_name: String
    var email: String
    var password: String
}

struct RegisterResponse: Codable {
    var message: String
    var status: String
}
