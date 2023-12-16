//
//  RegisterViewModel.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 28/11/23.
//

import Foundation
import Combine

final class RegisterViewModel {
    //MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    @Published var isEnabled = false
    @Published var showLoading = false
    @Published var errorMessage = ""
    @Published var userModel: User?

    var cancellables = Set<AnyCancellable>()
    let apiClient: FirebaseAPIClient

    //MARK: - Initialization
    init(apiClient: FirebaseAPIClient) {
        self.apiClient = apiClient
        formValidation()
    }

    //MARK: - Form Validation
    func formValidation() {
        Publishers.CombineLatest3($email, $password, $repeatPassword)
            .map { email, password, repeatPassword in
                return self.isValidEmail(email) &&
                self.isValidPassword(password) &&
                password == repeatPassword
            }
            .sink { [weak self] value in
                self?.isEnabled = value
            }
            .store(in: &cancellables)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "(?=.*[A-Z])(?=.*[0-9]).{6,12}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }

    //MARK: - User Register
    @MainActor
    func userRegister(withEmail email: String, password: String) {
        errorMessage = ""
        showLoading = true
        Task {
            do {
                userModel = try await apiClient.register(withEmail: email, password: password)
            } catch let error as BackendError {
                errorMessage = error.rawValue.localized
            }
            showLoading = false
        }
    }
}
