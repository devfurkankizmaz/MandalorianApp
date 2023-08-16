import Foundation

class CharacterListViewModel {
    private var characters: [MandalorianCharacter] = []
    var onDataFetch: ((Bool) -> Void)?

    func fetchCharacters(completion: @escaping (Bool) -> Void) {
        guard let baseURL = APIBaseURL.development.url else {
            completion(false)
            return
        }

        let characterURL = baseURL.appendingPathComponent(APIEndpoint.characters.path)
        onDataFetch?(true)
        NetworkHelper.shared.request(url: characterURL) { (result: Result<[MandalorianCharacter], Error>) in
            switch result {
            case .success(let data):
                self.characters = data
                completion(true)
                self.onDataFetch?(false)
            case .failure(let error):
                print(error)
                completion(false)
                self.onDataFetch?(false)
            }
            self.onDataFetch?(false)
        }
    }

    func numberOfCharacters() -> Int {
        return characters.count
    }

    func character(at index: Int) -> MandalorianCharacter? {
        return characters[index]
    }

    func updatedCharacter(at indexPath: IndexPath, with character: MandalorianCharacter) {
        characters[indexPath.row] = character
    }
}
