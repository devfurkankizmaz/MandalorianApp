import Alamofire
import Foundation

struct Empty: Codable {}

class CharacterDetailViewModel {
    func deleteCharacter(character: MandalorianCharacter?, callback: @escaping (Bool, String) -> Void) {
        guard let characterId = character?.id else {
            callback(false, "Err")
            return
        }

        guard let baseURL = APIBaseURL.development.url else {
            callback(false, "Invalid URL Format")
            return
        }

        let characterURL = baseURL.appendingPathComponent(APIEndpoint.characters.path)
        let pathWithID = characterURL.appendingPathComponent(characterId)

        NetworkHelper.shared.request(url: pathWithID, method: .delete) { (result: Result<Empty, Error>) in
            switch result {
            case .success:
                callback(true, "The Item successfully deleted.")

            case .failure(let error):
                print(error)
                callback(false, "Failure when the deletion")
            }
        }
    }

    func updateCharacter(character: MandalorianCharacter, callback: @escaping (Bool, String) -> Void) {
        guard let characterId = character.id else {
            callback(false, "Err")
            return
        }

        guard let baseURL = APIBaseURL.development.url else {
            callback(false, "Invalid URL Format")
            return
        }

        var params: Parameters = [
            "name": character.name,
            "type": character.type,
            "description": character.description,
            "quote": character.quote,
        ]

        if let imgUrl = character.imageUrl, let url = URL(string: imgUrl.absoluteString) {
            if url.scheme != nil && url.host != nil {
                params["imageUrl"] = imgUrl
            } else {
                callback(false, "Invalid URL format. Please enter a valid URL or leave blank")
                return
            }
        }

        let characterURL = baseURL.appendingPathComponent(APIEndpoint.characters.path)
        let pathWithID = characterURL.appendingPathComponent(characterId)

        NetworkHelper.shared.request(url: pathWithID, method: .put, parameters: params) { (result: Result<MandalorianCharacter, Error>) in
            switch result {
            case .success:
                callback(true, "The Item successfully updated.")

            case .failure(let error):
                print(error)
                callback(false, "Failure when the updated")
            }
        }
    }
}
