//
//  WelcomeView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 12/10/23.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func goToLoginVC()
    func goToRegister()
}

//MARK: - Constants
private enum Constants {
    static let cornerRadius: CGFloat = 7
    static let buttonSpacing: CGFloat = 25
    static let fontSize: CGFloat = 20
}

final class WelcomeView: UIView {

    weak var delegate: WelcomeViewDelegate?

    //MARK: - UI Components
    private lazy var logoApp: UIImageView = {
        let logoApp = UIImageView()
        logoApp.image = UIImage.logo
        logoApp.translatesAutoresizingMaskIntoConstraints = false
        return logoApp
    }()

    private lazy var loginButton = createButton(title: "Login", actionHandler: { [weak self] _ in self?.delegate?.goToLoginVC() })

    private lazy var registerButton = createButton(title: "Register", actionHandler: { [weak self] _ in self?.delegate?.goToRegister() })

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginButton, registerButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.buttonSpacing
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
extension WelcomeView {

    private func setup() {
        addSubviews()
        configureConstraints()
    }

    private func addSubviews() {
        addSubview(logoApp)
        addSubview(buttonStackView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            logoApp.widthAnchor.constraint(equalToConstant: 300),
            logoApp.heightAnchor.constraint(equalToConstant: 300),
            logoApp.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoApp.topAnchor.constraint(equalTo: topAnchor, constant: 150),

            loginButton.heightAnchor.constraint(equalToConstant: 70),
            registerButton.heightAnchor.constraint(equalToConstant: 70),

            buttonStackView.topAnchor.constraint(equalTo: logoApp.bottomAnchor, constant: 40),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }

    private func createButton(title: String, actionHandler: @escaping (UIAction) -> Void) -> CustomButton {
        return CustomButton(
            backgroundColor: UIColor.adjSecondary,
            title: title,
            font: UIFont.boldSystemFont(ofSize: Constants.fontSize),
            titleColor: UIColor.adjSecondaryText,
            cornerRadious: Constants.cornerRadius,
            action: UIAction(handler: actionHandler)
        )
    }
}
