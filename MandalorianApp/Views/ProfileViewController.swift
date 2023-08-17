//
//  RegisterViewController.swift
//  MandalorianApp
//
//  Created by Furkan Kızmaz on 17.08.2023.
//

import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Properties

    private lazy var viewModel: ProfileViewModel = {
        let vm = ProfileViewModel()
        return vm
    }()

    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Fullname: "
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.spaceMonoRegular.withSize(20)
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: "
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.spaceMonoRegular.withSize(20)
        return label
    }()

    private lazy var roleLabel: UILabel = {
        let label = UILabel()
        label.text = "Role: "
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.spaceMonoRegular.withSize(20)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 32
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
        stackView.addArrangedSubviews(fullnameLabel, emailLabel, roleLabel)
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
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    // MARK: - Actions
}
