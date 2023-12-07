//
//  WelcomeView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 12/10/23.
//

import UIKit
import Combine

private enum WelcomeTexts {
    static let register = "Register"
    static let login = "Login"
}

class WelcomeView: UIViewController {
    //MARK: - Properties
    private var welcomeViewModel = WelcomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    weak var delegate: NavigationDelegate?


    //MARK: - UI Components
    lazy var carousel: Carousel = {
        let carousel = Carousel(viewModel: welcomeViewModel)
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    private lazy var registerButton = CustomButton(title: WelcomeTexts.register, font: UIFont.systemFont(ofSize: 20), titleColor: .adjBlackWhite, backgroundColor: .adjSecondary, cornerRadious: 20, action: UIAction(handler: { [weak self] _ in
        self?.welcomeViewModel.registerButtonTapped.send()
    }))
    private lazy var loginButton = CustomButton(title: WelcomeTexts.login, font: UIFont.systemFont(ofSize: 20), titleColor: .adjBlackWhite, backgroundColor: .adjSecondary, cornerRadious: 20, action: UIAction(handler: { [weak self] _ in
        self?.welcomeViewModel.loginButtonTapped.send()
    }))
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.adjBlackWhite
        pageControl.currentPageIndicatorTintColor = UIColor.adjSecondary
        return pageControl
    }()

    //MARK: - View lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: - Private methonds
private extension WelcomeView {

    private func setup() {
        createBindingViewModel()
        view.backgroundColor = .adjWhiteBlack
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(carousel)
        view.addSubview(pageControl)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
    }

    func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            carousel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 600),
            carousel.widthAnchor.constraint(equalToConstant: 350),
            pageControl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }

    func createBindingViewModel() {
        welcomeViewModel.registerButtonTapped
            .sink { [weak self] in
                self?.navigateTo(RegisterView())
            }
            .store(in: &cancellables)

        welcomeViewModel.loginButtonTapped
            .sink { [weak self] in
                self?.navigateTo(LoginView())
            }
            .store(in: &cancellables)
    }
}

//MARK: - NavigationDelegate methods
extension WelcomeView: NavigationDelegate {
    func navigateTo(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
