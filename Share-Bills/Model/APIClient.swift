//
//  APIClient.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 25/11/23.
//

import UIKit

enum BackendError: String, Error {
    case invalidEmail = "Comprueba el email"
    case invalidPassword = "Comprueba tu password"
}

final class APIClient {
    func login(withEmail email: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
        return try simulateLoginBackendLogic(email: email, password: password)
    }
    func register(withEmail email: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
        return try simulateRegisterBackendLogic(email: email, password: password)
    }
}

private func simulateLoginBackendLogic(email: String, password: String) throws -> User {
    guard email == "snooopyman@gmail.com" else {
        print("El user no es Snoopy")
        throw BackendError.invalidEmail
    }
    guard password == "123456" else {
        print("El user no es Snoopy")
        throw BackendError.invalidPassword
    }
    print("Success")
    return .init(email: "snoopyman@gmail.com", token: "tokenL_123", sessionStart: .now)
}

private func simulateRegisterBackendLogic(email: String, password: String) throws -> User {
    print("Usuario registrado con éxito")
    return .init(email: email, token: "tokenR_123", sessionStart: .now)
}
