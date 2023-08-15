import Foundation

class CharacterDetailViewModel {
    weak var delegate: CharacterListViewControllerDelegate?

    func deleteCharacter(at indexPath: IndexPath) {
        delegate?.deleteItem(indexPath: indexPath)
    }

    func updateCharacter(at indexPath: IndexPath, with character: MandalorianCharacter) {
        delegate?.updateItem(at: indexPath, with: character)
    }
}
