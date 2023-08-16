//
//  ProductListView.swift
//  ShoppingApp
//
//  Created by Furkan Kızmaz on 12.08.2023.
//

import SnapKit
import UIKit

class CharacterDetailViewController: UIViewController {
    // MARK: - Properties
    
    var character: MandalorianCharacter?
    weak var delegate: CharacterListViewControllerDelegate?
    var indexPath: IndexPath?
    
    private lazy var viewModel: CharacterDetailViewModel = {
        let vm = CharacterDetailViewModel()
        return vm
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "questionmark")
        imageView.alpha = 0.8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.green.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.spaceMonoRegular.withSize(18)
        label.textColor = .white
        label.text = character?.name
        label.textAlignment = .center
        return label
    }()

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.spaceMonoRegular.withSize(16)
        label.textColor = .white
        label.text = character?.type
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.spaceMonoRegular.withSize(14)
        label.textColor = .white
        label.text = character?.description
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var quoteOpenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "quote.opening")
        imageView.alpha = 0.6
        return imageView
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.trispaceBold.withSize(20)
        label.textColor = .white
        label.text = character?.quote
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var quoteCloseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "quote.closing")
        imageView.alpha = 0.6
        return imageView
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        let originalImage = UIImage(systemName: "trash.fill")
        let resizedImage = originalImage?.resized(to: CGSize(width: 44, height: 44)) // Yeni boyutu ayarlayın
        let tintedResizedImage = resizedImage?.withRenderingMode(.alwaysTemplate)
        button.tintColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        button.contentMode = .scaleAspectFit
        button.setImage(tintedResizedImage, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        let originalImage = UIImage(systemName: "pencil")
        let resizedImage = originalImage?.resized(to: CGSize(width: 44, height: 44)) // Yeni boyutu ayarlayın
        let tintedResizedImage = resizedImage?.withRenderingMode(.alwaysTemplate)
        button.tintColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)
        button.contentMode = .scaleAspectFit
        button.setImage(tintedResizedImage, for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var editDeleteStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 64
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalCentering
        sv.alpha = 0.7
        return sv
    }()
    
    private lazy var quoteTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Character Quote..."
        return textField
    }()
    
    private lazy var submitButton: MandalorianButton = {
        let button = MandalorianButton()
        button.setTitle("Submit Changes", for: .normal)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        // button.layer.cornerRadius = 22
        button.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.6218136329)
        button.setTitleColor(UIColor.white, for: .normal)
        button.alpha = 0.9
        return button
    }()
    
    private lazy var popupView: UIView = {
        let popupView = UIView()
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 10
        return popupView
    }()
    
    private lazy var protectView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        if let character = character, let imageUrl = character.imageUrl {
            imageUrl.toImage { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        popupView.addSubviews(quoteTextField, submitButton)
        protectView.addSubviews(popupView)
        editDeleteStackView.addArrangedSubviews(deleteButton, editButton)
        view.addSubviews(imageView, nameLabel, typeLabel, descriptionLabel, quoteOpenImageView, quoteLabel, quoteCloseImageView, editDeleteStackView, protectView)
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        setupBackgroundImage()
        setupLayout()
        
        popupView.alpha = 1
    }
    
    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "peakpx")
        backgroundImage.alpha = 0.5
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(96)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(256)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        quoteOpenImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteOpenImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        quoteCloseImageView.snp.makeConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        editDeleteStackView.snp.makeConstraints { make in
            make.top.equalTo(quoteCloseImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        editButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        
        protectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popupView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(110)
        }
        
        quoteTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(44)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(quoteTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(44)
            make.trailing.equalToSuperview().offset(-44)
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Public Methods
    
    // MARK: - Actions
    
    @objc func deleteButtonTapped() {
        showDeleteConfirmationAlert(completion: { confirm in
            if confirm {
                self.viewModel.deleteCharacter(character: self.character) { confirm, message in
                    if confirm {
                        self.delegate?.fetchCharacters()
                        self.dismiss(animated: true)
                    } else {
                        self.showAlert(title: "Error", message: message)
                    }
                }
            }
        })
    }

    @objc func editButtonTapped() {
        protectView.isHidden = false
        quoteTextField.text = quoteLabel.text
    }
    
    @objc func submitButtonTapped() {
        var newCharacter: MandalorianCharacter?
        
        if let name = character?.name,
           let type = character?.type,
           let description = character?.description,
           let quote = quoteTextField.text
        {
            newCharacter = MandalorianCharacter(id: character?.id, name: name, type: type, description: description, imageUrl: character?.imageUrl ?? nil, quote: quote)
        }
        
        showEditConfirmationAlert(completion: { confirm in
            if confirm, let char = newCharacter {
                self.viewModel.updateCharacter(character: char) { confirm, message in
                    if confirm {
                        self.showAlert(title: "Success", message: message)
                        self.delegate?.fetchCharacters()
                        self.quoteLabel.text = self.quoteTextField.text
                        self.protectView.isHidden = true
                    } else {
                        self.showAlert(title: "Error", message: message)
                    }
                }
                
            } else {
                self.protectView.isHidden = true
            }
        })
    }
}

// MARK: - Extensions

extension CharacterDetailViewController: CharacterListViewControllerDelegate {
    func fetchCharacters() {}
}
