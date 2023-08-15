import Alamofire
import Foundation

class AddCharacterViewModel {
    weak var addCharacterDelegate: AddCharacterViewControllerDelegate?

    func addCharacter(_ character: MandalorianCharacter, completion: @escaping (String, Bool) -> Void) {
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
                completion("Invalid URL format. Please enter a valid URL or leave blank", false)
                return
            }
        }

        guard validateCharacter(character) else {
            completion("Invalid character data. Please provide valid information.", false)
            return
        }

        NetworkHelper.shared.request(url: "http://localhost:3000/characters", method: .post, parameters: params) { (result: Result<MandalorianCharacter, Error>) in
            switch result {
            case .success:
                completion("The character has been successfully saved.", true)
                self.addCharacterDelegate?.clearFields()
            case .failure(let error):
                completion(error.localizedDescription, false)
            }
        }
    }

    private func validateCharacter(_ character: MandalorianCharacter) -> Bool {
        guard !character.name.isEmpty,
              !character.type.isEmpty,
              !character.description.isEmpty,
              !character.quote.isEmpty
        else {
            return false
        }
        return true
    }
}
