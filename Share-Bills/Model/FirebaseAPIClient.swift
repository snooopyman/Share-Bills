//
//  FirebaseAPIClient.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 25/11/23.
//

import UIKit
import FirebaseAuth

enum BackendError: String, Error {
    case invalidEmail = "Comprueba el email"
    case invalidPassword = "Comprueba tu password"
}

final class FirebaseAPIClient {
    func login(withEmail email: String, password: String) async throws -> User {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return User(email: authDataResult.user.email ?? "", token: authDataResult.user.uid, sessionStart: Date())
    }

    func register(withEmail email: String, password: String) async throws -> User {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return User(email: authDataResult.user.email ?? "", token: authDataResult.user.uid, sessionStart: Date())
    }
}
