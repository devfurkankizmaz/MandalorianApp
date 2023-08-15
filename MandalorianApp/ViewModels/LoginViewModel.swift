import Foundation

class LoginViewModel {
    typealias AuthenticationCallback = (Bool) -> Void

    let mockUser = User(username: "Furkan", password: "123456")

    func authenticate(username: String, password: String, completion: AuthenticationCallback) {
        let isAuthenticated = (username == mockUser.username) && (password == mockUser.password)
        if isAuthenticated {
            completion(true)
        } else {
            completion(false)
        }
    }
}
