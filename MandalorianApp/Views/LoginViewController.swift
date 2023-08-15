//
//  LoginViewController.swift
//  MandalorianApp
//
//  Created by Furkan Kızmaz on 13.08.2023.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    // MARK: - Properties
    
    private lazy var forgotPassStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 6
        return sv
    }()
    
    private lazy var headerImageView: UIImageView = {
        let image = UIImage(named: "header2")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        // imageView.alpha = 0.7
        return imageView
    }()
    
    private lazy var footerImageView: UIImageView = {
        let image = UIImage(named: "footer")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.5
        imageView.layer.masksToBounds = true
        // imageView.alpha = 0.7
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        // imageView.contentMode = .scaleAspectFill
        // imageView.layer.masksToBounds = true
        imageView.alpha = 1
        return imageView
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Baby Yoda wants you to Log In."
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        label.font = AppFont.spaceMonoRegular.withSize(15)
        return label
    }()
    
    private lazy var forgotPassLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        label.text = "Did you forget your password?"
        label.textAlignment = .center
        label.font = AppFont.spaceMonoRegular.withSize(13)
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        return label
    }()
    
    private lazy var usernameTextField: MandalorianTextField = {
        let textField = MandalorianTextField()
        textField.customFont.name = AppFont.spaceMonoRegular.rawValue
        textField.leftSymbol = (symbolName: "person.fill", symbolColor: .black)
        textField.alpha = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        textField.placeholderColor = #colorLiteral(red: 0, green: 0.02550378069, blue: 0.1968309283, alpha: 1)
        textField.placeholderOpacity = 0.4
        textField.placeholder = "Enter Your Username..."

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
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: "Change Password", attributes: attributes)
        button.tintColor = .black
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        // button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: MandalorianButton = {
        let button = MandalorianButton()
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 22
        button.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.6218136329)
        button.setTitleColor(UIColor.white, for: .normal)
        button.alpha = 0.9
        return button
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        label.text = "Don't have an account?"
        label.textAlignment = .center
        label.font = AppFont.ralewayRegular.withSize(13)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.shadowOpacity = 0.4
        label.layer.shadowRadius = 2
        return label
    }()
    
    private lazy var signUpButton: MandalorianButton = {
        let button = MandalorianButton()
        button.setTitle("Sign Up!", for: .normal)
        // button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 9
        button.layer.borderColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 0.3978120279)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.6218136329)
        button.setTitleColor(UIColor.white, for: .normal)
        button.alpha = 0.9
        return button
    }()
    
    private lazy var signUpStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 1
        sv.alignment = .center
        return sv
    }()
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
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
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        forgotPassStackView.addArrangedSubview(forgotPassLabel)
        forgotPassStackView.addArrangedSubview(forgotPasswordButton)
        
        signUpStackView.addArrangedSubview(signUpLabel)
        signUpStackView.addArrangedSubview(signUpButton)
        
        view.addSubviews(
            headerImageView,
            logoImageView,
            loginLabel,
            usernameTextField,
            passwordTextField,
            loginButton,
            forgotPassStackView,
            footerImageView,
            signUpStackView
        )
        
        setupBackgroundImage()
        setupLayout()
    }
    
    private func setupLayout() {
        headerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        footerImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(10)
            make.height.equalTo(200)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
            make.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
            make.height.equalTo(44)
        }
        
        forgotPassStackView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        signUpStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-70)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(44)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions

    private lazy var viewModel = LoginViewModel()
    
    @objc func loginButtonTapped() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        viewModel.authenticate(username: username, password: password, completion: { [weak self] isAuthenticated in
            if isAuthenticated {
                let vc = CharacterListViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                self?.showAlert(message: "Invalid username or password")
            }
        })
    }
}
