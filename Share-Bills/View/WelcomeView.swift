//
//  WelcomeView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 12/10/23.
//

import UIKit

final class WelcomeView: UIView {

    private lazy var logoApp: UIImageView = {
        let logoApp = UIImageView()
        logoApp.image = UIImage(named: "logo")
        logoApp.translatesAutoresizingMaskIntoConstraints = false
        return logoApp
    }()

    private lazy var loginButton: CustomButton = {
        let button = CustomButton(
            backgroundColor: .clear,
            title: "Login", 
            font: UIFont(name: "SF Pro", size: 20),
            titleColor: UIColor(named: "adjBlueGray"),
            borderWidth: 1,
            action: UIAction(handler: { [weak self] _ in
                self?.showLogin()
            }))
        return button
    }()

    private lazy var registerButton: CustomButton = {
        let button = CustomButton(
            backgroundColor: .clear,
            title: "Register", 
            font: UIFont(name: "SF Pro", size: 20),
            titleColor: UIColor(named: "adjBlueGray"),
            borderWidth: 1,
            action: UIAction(handler: { [weak self] _ in
                self?.showRegister()
            }))
        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginButton, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "adjGrayBlue")
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
            buttonStackView.widthAnchor.constraint(equalToConstant: 300),
            buttonStackView.heightAnchor.constraint(equalToConstant: 100),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            buttonStackView.topAnchor.constraint(equalTo: logoApp.bottomAnchor, constant: 80)
        ])
    }

    private func showLogin() {
        print("Login Button pressed")
    }
    
    private func showRegister() {
        print("Register Button pressed")
    }
}

