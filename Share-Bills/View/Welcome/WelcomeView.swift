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

final class WelcomeView: UIView {

    weak var delegate: WelcomeViewDelegate?

    private lazy var logoApp: UIImageView = {
        let logoApp = UIImageView()
        logoApp.image = UIImage(named: "logo")
        logoApp.translatesAutoresizingMaskIntoConstraints = false
        return logoApp
    }()

    private lazy var loginButton: CustomButton = {
        let button = CustomButton(
            backgroundColor:  UIColor.adjSecondary,
            title: "Login",
            font: UIFont.boldSystemFont(ofSize: 20),
            titleColor: UIColor.adjSecondaryText,
            borderWidth: 0,
            cornerRadious: 7,
            action: UIAction(handler: { [weak self] _ in
                self?.showLogin()
            }))
        return button
    }()

    private lazy var registerButton: CustomButton = {
        let button = CustomButton(
            backgroundColor: UIColor.adjSecondary,
            title: "Register",
            font: UIFont.boldSystemFont(ofSize: 20),
            titleColor: UIColor.adjSecondaryText,
            borderWidth: 0,
            cornerRadious: 7,
            action: UIAction(handler: { [weak self] _ in
                self?.showRegister()
            }))
        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginButton, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.adjWhiteBlack
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    private func showLogin() {
        delegate?.goToLoginVC()
    }

    private func showRegister() {
        delegate?.goToRegister()
    }
}

