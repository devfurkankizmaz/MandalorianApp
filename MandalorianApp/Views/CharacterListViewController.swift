//
//  ShoppingListView.swift
//  ShoppingApp
//
//  Created by Furkan Kızmaz on 12.08.2023.
//

import SnapKit
import UIKit

class CharacterListViewController: UIViewController {
    // MARK: - Properties

    private lazy var viewModel: CharacterListViewModel = {
        let vm = CharacterListViewModel()
        vm.onDataFetch = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.spinner.startAnimating()
                } else {
                    self?.spinner.stopAnimating()
                }
            }
        }
        return vm
    }()

    private lazy var characterListCollectionView: UICollectionView = {
        var flowLayout = UICollectionViewFlowLayout()

        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "characterIdentifier")
        return cv
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
        setupView()
    }

    // MARK: - Private Methods

    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "peakpx")
        backgroundImage.alpha = 0.5
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }

    private func setupView() {
        let addButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(addCharacterButtonTapped))
        addButton.tintColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        addButton.image = UIImage(systemName: "plus.app")
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = "Characters"
        view.addSubviews(characterListCollectionView, spinner)
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        setupBackgroundImage()
        setupLayout()
    }

    private func setupLayout() {
        characterListCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 100, left: 16, bottom: 16, right: 16))
        }

        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc func addCharacterButtonTapped() {
        let addCharacterVC = AddCharacterViewController()
        addCharacterVC.delegate = self
        present(addCharacterVC, animated: true)
    }
}

// MARK: - Extensions

extension CharacterListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterIdentifier", for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let character = viewModel.character(at: indexPath.row) {
            cell.configure(with: character)
        }

        return cell
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout, CharacterListViewControllerDelegate {
    func fetchCharacters() {
        viewModel.fetchCharacters { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.characterListCollectionView.reloadData()
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width - 60, height: 330)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = CharacterDetailViewController()
        detailVC.delegate = self
        detailVC.indexPath = indexPath
        detailVC.character = viewModel.character(at: indexPath.row)
        present(detailVC, animated: true)
    }
}

protocol CharacterListViewControllerDelegate: AnyObject {
    func fetchCharacters()
}
