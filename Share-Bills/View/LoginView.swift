//
//  LoginView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 14/10/23.
//

import UIKit

//MARK: - Constants
private enum Constants {
    static let cornerRadius: CGFloat = 20
    static let textFieldSpacing: CGFloat = 25
    static let fontSize: CGFloat = 30
    static let borderWidth: CGFloat = 2
}

final class LoginView: UIView {

    weak var delegate: NavigationDelegate?

    //MARK: - UI Components
    private lazy var title = createLabel(text: "Login")
    private lazy var userNameTextField = createTextField(text: "", placeholder: "username")
    private lazy var passwordTextField = createTextField(text: "", placeholder: "password", isPassword: true)
    private lazy var loginButton = createButton(title: "Login", vc: DashboardViewController())

    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, passwordTextField])
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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

//MARK: - Private Methods
extension LoginView {

    private func setup() {
        addSubviews()
        configureConstraints()
    }

    private func addSubviews() {
        addSubview(title)
        addSubview(textFieldStackView)
        addSubview(loginButton)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 160),
            title.widthAnchor.constraint(equalToConstant: 170),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 80),

            userNameTextField.heightAnchor.constraint(equalToConstant: 60),
            userNameTextField.widthAnchor.constraint(equalToConstant: 240),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.widthAnchor.constraint(equalToConstant: 240),
            textFieldStackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            textFieldStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            loginButton.heightAnchor.constraint(equalToConstant: 90),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 35)
        ])
    }

    private func createLabel(text: String) -> CustomLabel {
        return CustomLabel(
            text: text,
            textColor: UIColor.adjSecondary,
            font: UIFont.boldSystemFont(ofSize: 65)
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
            borderColor: UIColor.adjSecondary,
            cornerRadius: Constants.cornerRadius
        )
    }

    private func createButton(title: String, vc: UIViewController) -> CustomButton {
        return CustomButton(
            title: title,
            font: UIFont.boldSystemFont(ofSize: Constants.fontSize),
            titleColor: UIColor.adjSecondaryText,
            backgroundColor: UIColor.adjSecondary,
            cornerRadious: Constants.cornerRadius,
            action: UIAction(handler: { [weak self] _ in self?.delegate?.navigateTo(vc) })
        )
    }
}
