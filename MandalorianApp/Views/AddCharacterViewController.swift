//
//  AddCharacterViewController.swift
//  MandalorianApp
//
//  Created by Furkan Kızmaz on 15.08.2023.
//

import SnapKit
import UIKit

class AddCharacterViewController: UIViewController {
    // MARK: - Properties

    weak var delegate: CharacterListViewControllerDelegate?

    private lazy var viewModel: AddCharacterViewModel = {
        let vm = AddCharacterViewModel()
        vm.addCharacterDelegate = self
        return vm
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.spaceMonoRegular.withSize(18)
        label.textColor = .white
        label.text = "Enter your Mandalorian Character Descriptions"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var nameTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Name..."
        return textField
    }()

    private lazy var typeTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Type..."
        return textField
    }()

    private lazy var descriptionTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Information..."
        return textField
    }()

    private lazy var quoteTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Quote..."
        return textField
    }()

    private lazy var urlTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Image URL..."
        return textField
    }()

    private lazy var tfsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 16
        sv.distribution = .equalCentering
        return sv
    }()

    private lazy var addButton: MandalorianButton = {
        let button = MandalorianButton()
        button.setTitle("Add Character", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 22
        button.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.6218136329)
        button.setTitleColor(UIColor.white, for: .normal)
        button.alpha = 0.9
        return button
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
        tfsStackView.addArrangedSubviews(nameTextField, typeTextField, descriptionTextField, quoteTextField, urlTextField)
        view.addSubviews(titleLabel, tfsStackView, addButton)
        setupBackgroundImage()
        setupLayout()
    }

    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "peakpx")
        backgroundImage.alpha = 0.5
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(256)
        }
        typeTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(256)
        }
        descriptionTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(256)
        }
        quoteTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(256)
        }
        urlTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(256)
        }
        tfsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(tfsStackView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(256)
        }
    }

    // MARK: - Actions

    @objc func addButtonTapped() {
        guard let name = nameTextField.text,
              let type = typeTextField.text,
              let description = descriptionTextField.text,
              let quote = quoteTextField.text,
              let imageURLString = urlTextField.text
        else {
            return
        }

        let imageURL = URL(string: imageURLString)

        let character = MandalorianCharacter(name: name, type: type, description: description, imageUrl: imageURL, quote: quote)

        viewModel.addCharacter(character) { message, confirm in
            if confirm {
                self.delegate?.fetchCharacters()
                self.showAlert(title: "Success", message: message)

            } else {
                self.showAlert(title: "Error", message: message)
            }
        }
    }
}

protocol AddCharacterViewControllerDelegate: AnyObject {
    func clearFields()
}

extension AddCharacterViewController: AddCharacterViewControllerDelegate {
    func clearFields() {
        descriptionTextField.text = ""
        nameTextField.text = ""
        quoteTextField.text = ""
        urlTextField.text = ""
        typeTextField.text = ""
    }
}
