import Alamofire
import Foundation

class NetworkHelper {
    static let shared = NetworkHelper()

    func request<T: Codable>(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: JSONEncoding.default).validate().responseJSON { response in

            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
