//
//  WelcomeView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 12/10/23.
//

import UIKit

enum WelcomeButtonTitle {
    static let register = "Register"
    static let login = "Login"
}

class WelcomeView: UIView {
    weak var delegate: NavigationDelegate?

    //MARK: - UI Components
    lazy var carousel: Carousel = {
        let items = CarouselItemFactory.createItems()
        let carousel = Carousel(items: items)

        carousel.setupPageControl(pageControl)
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()

    private lazy var registerButton = createButton(title: WelcomeButtonTitle.register, goToVC: RegisterViewController())
    private lazy var loginButton = createButton(title: WelcomeButtonTitle.login, goToVC: LoginViewController())

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.adjBlackWhite
        pageControl.currentPageIndicatorTintColor = UIColor.adjSecondary
        return pageControl
    }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methonds
private extension WelcomeView {

    private func setupView() {
        backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(carousel)
        addSubview(pageControl)
        addSubview(registerButton)
        addSubview(loginButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            carousel.centerXAnchor.constraint(equalTo: centerXAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 600),
            carousel.widthAnchor.constraint(equalToConstant: 350),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }

    func createButton(title: String, goToVC: UIViewController) -> CustomButton {
        return CustomButton(
            title: title,
            font: UIFont.systemFont(ofSize: 20),
            titleColor: UIColor.adjSecondaryText,
            backgroundColor: UIColor.adjSecondary,
            cornerRadious: 20,
            action: UIAction(handler: { [weak self] _ in self?.delegate?.navigateTo(goToVC) })
        )
    }
}
