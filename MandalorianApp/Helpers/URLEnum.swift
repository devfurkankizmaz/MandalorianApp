import Foundation

enum Endpoint {
    static let baseURL = "http://localhost:3000"

    case character(id: String = "")

    var apiURL: String {
        switch self {
        case .character(let id):
            return Endpoint.baseURL + "/characters" + "/\(id)"
        }
    }
}

enum APIBaseURL: String {
    case development = "http://localhost:3000"

    var url: URL? {
        return URL(string: self.rawValue)
    }
}

enum APIEndpoint: String {
    case characters = "/characters"

    var path: String {
        return self.rawValue
    }
}
