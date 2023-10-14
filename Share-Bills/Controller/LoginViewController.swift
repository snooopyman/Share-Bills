//
//  LoginViewController.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 14/10/23.
//

import UIKit

class LoginViewController: UIViewController, NavigationDelegate {

    override func loadView() {
        let loginView = LoginView()
        loginView.delegate = self
        self.view = loginView
    }

    func navigateTo(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
