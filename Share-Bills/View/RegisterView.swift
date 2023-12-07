//
//  RegisterView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 14/10/23.
//

import UIKit
import Combine

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

final class RegisterView: UIViewController {
    //MARK: - Properties
    private let registerViewModel = RegisterViewModel(apiClient: FirebaseAPIClient())
    private var cancellables = Set<AnyCancellable>()
    weak var delegate: NavigationDelegate?

    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    //MARK: - UI Components
    private lazy var titleLabel = createLabel(text: Constants.titleLabel)
    private lazy var emailTextField = createTextField(text: "", placeholder: Constants.email)
    private lazy var passwordTextField = createTextField(text: "", placeholder: Constants.password, isPassword: true)
    private lazy var repeatPasswordTextField = createTextField(text: "", placeholder: Constants.repeatPassword, isPassword: true)
    private lazy var registerButton: CustomButton = {
        CustomButton(title: Constants.registerButton, filled: true) {
            self.startRegister()
        }
    }()
    private lazy var termsAndPrivacyLabel = createTermsAndPrivacyLabel()
    private lazy var errorLabel = createLabel(text: "")

    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, repeatPasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = Constants.textFieldSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}

//MARK: - Private Methods
private extension RegisterView {

    func setup() {
        createBindingViewModel()
        view.backgroundColor = UIColor.adjWhiteBlack
        addSubviews()
        configureConstraints()
    }

    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(textFieldStackView)
        view.addSubview(registerButton)
        view.addSubview(termsAndPrivacyLabel)
        view.addSubview(errorLabel)
    }

    func configureConstraints() {
        let guide = view.safeAreaLayoutGuide
        let textFields = [emailTextField, passwordTextField, repeatPasswordTextField]
        let textFieldSize: CGSize = CGSize(width: 240, height: 50)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            textFieldStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            textFieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 25),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 270),
            termsAndPrivacyLabel.leadingAnchor.constraint(equalTo: registerButton.leadingAnchor),
            termsAndPrivacyLabel.trailingAnchor.constraint(equalTo: registerButton.trailingAnchor),
            termsAndPrivacyLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
            errorLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: termsAndPrivacyLabel.bottomAnchor, constant: 20)
        ])

        for textField in textFields {
            NSLayoutConstraint.activate([
                textField.heightAnchor.constraint(equalToConstant: textFieldSize.height),
                textField.widthAnchor.constraint(equalToConstant: textFieldSize.width)
            ])
        }
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
            font: UIFont.systemFont(ofSize: Constants.fontSize),
            backgroundColor: UIColor.adjWhiteBlack,
            borderWidth: Constants.borderWidth,
            borderColor: UIColor.adjBlackWhite,
            cornerRadius: Constants.cornerRadius
        )
    }
    
    func createButton(title: String, goToVC: UIViewController, filled: Bool) -> CustomButton {
        CustomButton(
            title: title,
            font: UIFont.boldSystemFont(ofSize: 20),
            titleColor: UIColor.adjSecondaryText,
            backgroundColor: UIColor.adjSecondary,
            cornerRadius: 20,
            filled: filled,
            action: { [weak self] in
                self?.delegate?.navigateTo(goToVC)
            }
        )
    }

    func createTermsAndPrivacyLabel() -> UITextView {
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

    func startRegister() {
        registerViewModel.userRegister(withEmail: emailTextField.text?.lowercased() ?? "",
                                 password: passwordTextField.text?.lowercased() ?? "")
    }

    func createBindingViewModel() {
        emailTextField.textPublisher
            .assign(to: \RegisterViewModel.email, on: registerViewModel)
            .store(in: &cancellables)

        passwordTextField.textPublisher
            .assign(to: \RegisterViewModel.password, on: registerViewModel)
            .store(in: &cancellables)

        registerViewModel.$isEnabled
            .assign(to: \.isEnabled, on: registerButton)
            .store(in: &cancellables)

        registerViewModel.$showLoading
            .assign(to: \.configuration!.showsActivityIndicator, on: registerButton)
            .store(in: &cancellables)

        registerViewModel.$errorMessage
            .assign(to: \UILabel.text!, on: errorLabel)
            .store(in: &cancellables)

        registerViewModel.$userModel.sink { [weak self] user in
            guard user != nil else { return }
            print("user registered - go to dashboard")
            let dashboardView = DashboardView()
            self?.navigateTo(dashboardView)
        }.store(in: &cancellables)
    }
}

//MARK: - NavigationDelegate methods
extension RegisterView: NavigationDelegate {
    func navigateTo(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
