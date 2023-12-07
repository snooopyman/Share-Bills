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
                return email.count > 5 && password.count > 5
            }
            .sink { value in
                self.isEnabled = value
            }.store(in: &cancellables)
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
                errorMessage = error.rawValue
            }
            showLoading = false
        }
    }
}
