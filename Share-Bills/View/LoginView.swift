//
//  LoginView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 25/11/23.
//

import UIKit
import Combine

//MARK: - Constants
private enum LoginViewLayout {
    static let cornerRadius: CGFloat = 20
    static let textFieldSpacing: CGFloat = 25
    static let fontSize: CGFloat = 20
    static let borderWidth: CGFloat = 2
}

private enum LoginViewText {
    static let loginTitle = "Sign In"
    static let emailPlaceholder = "Add email"
    static let passwordPlaceholder = "Add password"
    static let loginButtonTitle = "Login"
}

final class LoginView: UIViewController {
    //MARK: - Properties
    private let loginViewModel = LoginViewModel(apiClient: APIClient())
    private var cancellables = Set<AnyCancellable>()
    weak var delegate: NavigationDelegate?

    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    //MARK: - UI Components
    private lazy var errorLabel = createLabel(text: "")
    private lazy var titleLabel = createLabel(text: LoginViewText.loginTitle)
    private lazy var emailTextField = createTextField(text: "", placeholder: LoginViewText.emailPlaceholder)
    private lazy var passwordTextField = createTextField(text: "", placeholder: LoginViewText.passwordPlaceholder, isPassword: true)
    private lazy var loginButton: CustomButton = {
        CustomButton(title: LoginViewText.loginTitle, filled: true) {
            self.startLogin()
        }
    }()
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = LoginViewLayout.textFieldSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}

//MARK: - Private Methods
private extension LoginView {

    func setup() {
        view.backgroundColor = UIColor.adjWhiteBlack
        createBindingViewModel()
        addSubviews()
        configureConstraints()
    }

    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(textFieldStackView)
        view.addSubview(loginButton)
        view.addSubview(errorLabel)
    }

    func configureConstraints() {
        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 160),
            titleLabel.widthAnchor.constraint(equalToConstant: 170),
            titleLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),

            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 240),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 240),
            textFieldStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            textFieldStackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),

            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 270),
            loginButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 25),
            errorLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
    }

    func createLabel(text: String) -> CustomLabel {
        CustomLabel(
            text: text,
            textColor: UIColor.adjBlackWhite,
            font: UIFont.boldSystemFont(ofSize: 40)
        )
    }

    func createTextField(text: String, placeholder: String, isPassword: Bool = false) -> CustomTextField {
        CustomTextField(
            text: text,
            placeholder: placeholder,
            isPassword: isPassword,
            font: UIFont.systemFont(ofSize: LoginViewLayout.fontSize),
            backgroundColor: UIColor.adjWhiteBlack,
            borderWidth: LoginViewLayout.borderWidth,
            borderColor: UIColor.adjBlackWhite,
            cornerRadius: LoginViewLayout.cornerRadius
        )
    }

    func startLogin() {
        loginViewModel.userLogin(withEmail: emailTextField.text?.lowercased() ?? "",
                                 password: passwordTextField.text?.lowercased() ?? "")
    }

    func createBindingViewModel() {
        emailTextField.textPublisher
            .assign(to: \LoginViewModel.email, on: loginViewModel)
            .store(in: &cancellables)

        passwordTextField.textPublisher
            .assign(to: \LoginViewModel.password, on: loginViewModel)
            .store(in: &cancellables)

        loginViewModel.$isEnabled
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)

        loginViewModel.$showLoading
            .assign(to: \.configuration!.showsActivityIndicator, on: loginButton)
            .store(in: &cancellables)

        loginViewModel.$errorMessage
            .assign(to: \UILabel.text!, on: errorLabel)
            .store(in: &cancellables)

        loginViewModel.$userModel.sink { [weak self] user in
            guard user != nil else { return }
            print("user logeado - go to dashboard")
            let dashboardView = DashboardView()
            self?.navigateTo(dashboardView)
        }.store(in: &cancellables)
    }
}

//MARK: - NavigationDelegate methods
extension LoginView: NavigationDelegate {
    func navigateTo(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
