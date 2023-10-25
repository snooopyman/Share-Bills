//
//  WelcomeView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 12/10/23.
//

import UIKit

class WelcomeView: UIView {
    weak var delegate: NavigationDelegate?

    //MARK: - UI Components
    lazy var carousel: Carousel = {
        let items = [
            createCarouselItem(imageName: "cool", title: "Cool", description: "Descripción Cool"),
            createCarouselItem(imageName: "relax", title: "Relax", description: "Descripción Relax"),
            createCarouselItem(imageName: "sit", title: "Sit", description: "Descripción Sit"),
            createCarouselItem(imageName: "stand", title: "Stand", description: "Descripción Stand")
        ].compactMap { $0 }

        let carousel = Carousel(frame: .zero, items: items)
        carousel.setupPageControl(pageControl)
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()

    private lazy var registerButton = createButton(title: "Register", vc: RegisterViewController())
    private lazy var loginButton = createButton(title: "Login", vc: LoginViewController())

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
    
    func createCarouselItem(imageName: String, title: String, description: String) -> CarouselItem? {
        guard let image = UIImage(named: imageName) else {
            print("No se pudo encontrar la imagen \(imageName)")
            return nil
        }
        return CarouselItem(image: image, title: title, description: description)
    }

    func createButton(title: String, vc: UIViewController) -> CustomButton {
        return CustomButton(
            title: title,
            font: UIFont.systemFont(ofSize: 20),
            titleColor: UIColor.adjSecondaryText,
            backgroundColor: UIColor.adjSecondary,
            cornerRadious: 20,
            action: UIAction(handler: { [weak self] _ in self?.delegate?.navigateTo(vc) })
        )
    }
}
