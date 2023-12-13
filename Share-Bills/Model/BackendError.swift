//
//  BackendError.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 13/12/23.
//

import Foundation

enum BackendError: String, Error {
    case invalidEmail = "Check your email"
    case invalidPassword = "Check your password"
}
