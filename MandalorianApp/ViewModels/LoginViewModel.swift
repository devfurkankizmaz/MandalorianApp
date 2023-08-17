import Alamofire
import Foundation

class LoginViewModel {
    let url = "https://api.iosclass.live/v1/auth/login"

    func login(_ input: Login, completion: @escaping (String, Bool) -> Void) {
        var params: Parameters = [
            "email": input.email,
            "password": input.password,
        ]

        NetworkHelper.shared.request(url: url, method: .post, parameters: params) { (result: Result<LoginResponse, Error>) in
            switch result {
            case .success(let data):
                _ = KeychainHelper.saveAccessToken(token: data.accessToken)
                completion("Logged in successfully.", true)
            case .failure(let error):
                completion(error.localizedDescription, false)
            }
        }
    }
}
