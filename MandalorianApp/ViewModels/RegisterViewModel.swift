import Alamofire
import Foundation

class RegisterViewModel {
    let url = "https://api.iosclass.live/v1/auth/register"

    func register(_ input: Register, completion: @escaping (String, Bool) -> Void) {
        var params: Parameters = [
            "full_name": input.full_name,
            "email": input.email,
            "password": input.password,
        ]

        NetworkHelper.shared.request(url: url, method: .post, parameters: params) { (result: Result<RegisterResponse, Error>) in
            switch result {
            case .success(let data):
                completion(data.message, true)
            case .failure(let error):
                completion(error.localizedDescription, false)
            }
        }
    }
}
