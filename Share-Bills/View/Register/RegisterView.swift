//
//  RegisterView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 14/10/23.
//

import UIKit

//MARK: - Constants
private enum Constants {
    static let cornerRadius: CGFloat = 20
    static let textFieldSpacing: CGFloat = 25
    static let fontSize: CGFloat = 20
    static let borderWidth: CGFloat = 2
    static let titleLabel: String = "Join us"
    static let email: String = "email"
    static let password: String = "password"
    static let repeatPassword: String = "Repeat password"
    static let registerButton: String = "Sign up"
}

final class RegisterView: UIView {

    weak var delegate: NavigationDelegate?

    //MARK: - UI Components
    private lazy var title = createLabel(text: Constants.titleLabel)
    private lazy var emailTextField = createTextField(text: "", placeholder: Constants.email)
    private lazy var passwordTextField = createTextField(text: "", placeholder: Constants.password, isPassword: true)
    private lazy var repeatPasswordTextField = createTextField(text: "", placeholder: Constants.repeatPassword, isPassword: true)
    private lazy var registerButton = createButton(title: Constants.registerButton, goToVC: DashboardViewController())
    private lazy var termsAndPrivacyLabel = createTermsAndPrivacyLabel()

    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, repeatPasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = Constants.textFieldSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.adjWhiteBlack
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private Methods
extension RegisterView {

    private func setup() {
        addSubviews()
        configureConstraints()
    }

    private func addSubviews() {
        addSubview(title)
        addSubview(textFieldStackView)
        addSubview(registerButton)
        addSubview(termsAndPrivacyLabel)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 120),

            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 240),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 240),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            repeatPasswordTextField.widthAnchor.constraint(equalToConstant: 240),
            textFieldStackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40),
            textFieldStackView.centerXAnchor.constraint(equalTo: centerXAnchor),


            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 25),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 270),

            termsAndPrivacyLabel.leadingAnchor.constraint(equalTo: registerButton.leadingAnchor),
            termsAndPrivacyLabel.trailingAnchor.constraint(equalTo: registerButton.trailingAnchor),
            termsAndPrivacyLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
        ])
    }

    private func createLabel(text: String) -> CustomLabel {
        return CustomLabel(
            text: text,
            textColor: UIColor.adjBlackWhite,
            font: UIFont.boldSystemFont(ofSize: 40)
        )
    }

    private func createTextField(text: String, placeholder: String, isPassword: Bool = false) -> CustomTextField {
        return CustomTextField(
            text: text,
            placeholder: placeholder,
            isPassword: isPassword,
            font: UIFont.systemFont(ofSize: Constants.fontSize),
            backgroundColor: UIColor.adjWhiteBlack,
            borderWidth: Constants.borderWidth,
            borderColor: UIColor.adjBlackWhite,
            cornerRadius: Constants.cornerRadius
        )
    }
    
    func createButton(title: String, goToVC: UIViewController) -> CustomButton {
        return CustomButton(
            title: title,
            font: UIFont.boldSystemFont(ofSize: 20),
            titleColor: UIColor.adjSecondaryText,
            backgroundColor: UIColor.adjSecondary,
            cornerRadious: 20,
            action: UIAction(handler: { [weak self] _ in self?.delegate?.navigateTo(goToVC) })
        )
    }

    private func createTermsAndPrivacyLabel() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.textAlignment = .center

        let attributedString = NSMutableAttributedString(string: "By signing up or signing in, you agree to our ", attributes: [.foregroundColor: UIColor.adjSecondaryText])

        let termsAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .link: URL(string: "https://github.com/snooopyman")!
        ]
        let termsAttributedString = NSAttributedString(string: "Terms of Use", attributes: termsAttributes)

        attributedString.append(termsAttributedString)

        attributedString.append(NSAttributedString(string: " and ", attributes: [.foregroundColor: UIColor.adjSecondaryText]))

        let privacyAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .link: URL(string: "https://github.com/snooopyman?tab=repositories")!
        ]
        let privacyAttributedString = NSAttributedString(string: "Privacy Policy", attributes: privacyAttributes)

        attributedString.append(privacyAttributedString)

        textView.attributedText = attributedString
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]

        return textView
    }
}

