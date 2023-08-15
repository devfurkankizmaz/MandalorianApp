//
//  ProductViewCell.swift
//  ShoppingApp
//
//  Created by Furkan Kızmaz on 13.08.2023.
//
import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.alpha = 0.7
        imageView.image = UIImage(systemName: "questionmark")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.spaceMonoRegular.withSize(14)
        label.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        return label
    }()

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.spaceMonoRegular.withSize(14)
        label.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = UIImage(systemName: "questionmark")
        characterImageView.contentMode = .scaleAspectFit
        nameLabel.text = nil
        typeLabel.text = nil
    }

    // MARK: - Private Methods

    private func setupView() {
        contentView.addSubviews(characterImageView, nameLabel, typeLabel)
        layer.cornerRadius = 10
        layer.borderWidth = 0.7
        layer.borderColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        backgroundColor = .clear
        alpha = 0.8
        setupLayout()
        characterImageView.layer.cornerRadius = 95
    }

    private func setupLayout() {
        characterImageView.snp.makeConstraints { make in
            make.width.height.equalTo(190)
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }

        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }

    // MARK: - Public Methods

    public func configure(with character: MandalorianCharacter) {
        nameLabel.text = character.name
        typeLabel.text = character.type

        if let imageUrl = character.imageUrl, let url = URL(string: imageUrl.absoluteString) {
            url.toImage { [weak self] image in
                DispatchQueue.main.async {
                    self?.characterImageView.image = image
                    self?.characterImageView.contentMode = .scaleAspectFill
                }
            }
        }
    }

    // MARK: - Actions
}
