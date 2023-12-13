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
        Publishers.CombineLatest($email, $password)
            .map { email, password in
                return self.isEmailValid(email) && self.isPasswordValid(password)
            }
            .sink { value in
                self.isEnabled = value
            }.store(in: &cancellables)
    }

    private func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    private func isPasswordValid(_ password: String) -> Bool {
        let passwordRegEx = "(?=.*[A-Z])(?=.*[0-9]).{6,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
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
