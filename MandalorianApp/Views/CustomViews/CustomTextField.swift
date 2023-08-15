import UIKit

class MandalorianTextField: UITextField {
    var insets: UIEdgeInsets

    init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        self.insets = insets
        super.init(frame: .zero)
        setupTextField()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var customFont: (name: String, size: CGFloat) = (name: AppFont.spaceMonoRegular.rawValue, size: 14) {
        didSet {
            font = UIFont(name: customFont.name, size: customFont.size)
        }
    }

    var rightButtonToggle: (onSymbolName: String, offSymbolName: String, color: UIColor)? {
        didSet {
            updateRightViewButton()
        }
    }

    var leftSymbol: (symbolName: String?, symbolColor: UIColor?) {
        didSet {
            updateSymbolImageView()
        }
    }

    var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceHolder()
        }
    }

    var placeholderOpacity: CGFloat = 0.5 {
        didSet {
            updatePlaceHolder()
        }
    }

    private func setupTextField() {
        font = UIFont(name: customFont.name, size: customFont.size)
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        autocorrectionType = .no
        alpha = 0.8

        let emptyRightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        rightView = emptyRightView
        rightViewMode = .always

        updateSymbolImageView()
        updatePlaceHolder()
    }

    private func updatePlaceHolder() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor.withAlphaComponent(placeholderOpacity)
        ]
        attributedPlaceholder = NSAttributedString(string: "Default", attributes: attributes)
    }

    private func updateSymbolImageView() {
        if let symbolName = leftSymbol.symbolName, let symbolImage = UIImage(systemName: symbolName) {
            let symbolContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
            let symbolImageView = UIImageView(image: symbolImage)
            symbolContainerView.addSubview(symbolImageView)
            symbolImageView.center = symbolContainerView.center
            guard let symbolColor = leftSymbol.symbolColor else { return }
            symbolImageView.tintColor = symbolColor
            symbolImageView.alpha = 0.5

            leftView = symbolContainerView
            leftViewMode = .always
        } else {
            let emptyLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            leftView = emptyLeftView
            leftViewMode = .always
        }
    }

    private var isRightButtonOn = false

    private func updateRightViewButton() {
        if let rightButtonToggle = rightButtonToggle {
            let symbolName = isRightButtonOn ? rightButtonToggle.onSymbolName : rightButtonToggle.offSymbolName
            if let symbolImage = UIImage(systemName: symbolName) {
                let symbolContainerView = UIButton(frame: CGRect(x: 0, y: 0, width: 26, height: 36))
                let symbolImageView = UIImageView(image: symbolImage)
                symbolContainerView.addTarget(self, action: #selector(rightButtonTapped(sender:)), for: .touchUpInside)
                symbolContainerView.addSubview(symbolImageView)
                symbolImageView.center = symbolContainerView.center
                symbolImageView.tintColor = rightButtonToggle.color
                symbolImageView.alpha = 0.5
                rightView = symbolContainerView
                rightViewMode = .always
            }
        } else {
            let emptyRightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            rightView = emptyRightView
            rightViewMode = .always
        }
    }

    @objc private func rightButtonTapped(sender: UIButton) {
        isRightButtonOn.toggle()
        updateRightViewButton()
        isSecureTextEntry.toggle()
    }
}
