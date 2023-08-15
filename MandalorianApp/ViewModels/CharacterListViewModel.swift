import Foundation

class CharacterListViewModel {
    private var characters: [MandalorianCharacter] = []
    var onDataFetch: ((Bool) -> Void)?

    func fetchCharacters(completion: @escaping (Bool) -> Void) {
        onDataFetch?(true)
        NetworkHelper.shared.request(url: "http://localhost:3000/characters") { (result: Result<[MandalorianCharacter], Error>) in
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

    func deleteCharacter(at indexPath: IndexPath) {
        characters.remove(at: indexPath.row)
    }

    func updatedCharacter(at indexPath: IndexPath, with character: MandalorianCharacter) {
        characters[indexPath.row] = character
    }
}
