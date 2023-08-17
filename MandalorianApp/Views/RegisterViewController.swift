//
//  RegisterViewController.swift
//  MandalorianApp
//
//  Created by Furkan Kızmaz on 17.08.2023.
//

import SnapKit
import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Properties

    private lazy var viewModel: RegisterViewModel = {
        let vm = RegisterViewModel()
        return vm
    }()

    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.text = "Please fill out the following information."
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.spaceMonoRegular.withSize(14)
        return label
    }()

    private lazy var fullNameTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.leftSymbol = (symbolName: "person.fill", symbolColor: .black)
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Your Fullname..."
        return textField
    }()

    private lazy var emailTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.leftSymbol = (symbolName: "envelope.fill", symbolColor: .black)
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Your Email..."
        return textField
    }()

    private lazy var passwordTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.leftSymbol = (symbolName: "lock.fill", symbolColor: .black)
        textField.rightButtonToggle = (onSymbolName: "eye.fill", offSymbolName: "eye.slash", color: .black)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.alpha = 0.8
        textField.placeholder = "Enter Your Password..."
        textField.isSecureTextEntry = true

        return textField
    }()

    private lazy var passwordReplyTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.leftSymbol = (symbolName: "lock.fill", symbolColor: .black)
        textField.rightButtonToggle = (onSymbolName: "eye.fill", offSymbolName: "eye.slash", color: .black)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.alpha = 0.8
        textField.placeholder = "Reply Your Password..."
        textField.isSecureTextEntry = true

        return textField
    }()

    private lazy var signUpButton: MandalorianButton = {
        let button = MandalorianButton()
        button.setTitle("Sign Up!", for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 22
        button.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.6218136329)
        button.setTitleColor(UIColor.white, for: .normal)
        button.alpha = 0.9
        return button
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 24
        sv.alignment = .center
        return sv
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        stackView.addArrangedSubviews(introLabel, fullNameTextField, emailTextField, passwordTextField, passwordReplyTextField, signUpButton)
        view.addSubviews(stackView)
        view.backgroundColor = .white
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
        fullNameTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(300)
        }
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(300)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(300)
        }
        passwordReplyTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(300)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.centerX.equalToSuperview()
        }
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(300)
        }
    }

    private func clearFields() {
        fullNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        passwordReplyTextField.text = ""
    }

    // MARK: - Actions

    @objc func signUpButtonTapped() {
        guard let name = fullNameTextField.text,
              let email = emailTextField.text,
              let pass = passwordTextField.text,
              let reply = passwordReplyTextField.text
        else {
            return
        }

        if pass != reply {
            showAlert(title: "Error", message: "Passwords are not matched.")
        } else {
            let user = Register(full_name: name, email: email, password: pass)

            viewModel.register(user, completion: { message, confirm in
                if confirm {
                    self.showAlert(title: "Success", message: message)
                    self.clearFields()

                } else {
                    self.showAlert(title: "Error", message: message)
                }
            })
        }
    }
}
