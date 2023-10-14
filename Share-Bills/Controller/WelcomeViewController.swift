//
//  ViewController.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 11/10/23.
//

import UIKit

class WelcomeViewController: UIViewController, WelcomeViewDelegate {

    override func loadView() {
        let welcomeView = WelcomeView()
        welcomeView.delegate = self
        self.view = welcomeView
    }

    func goToLoginVC() {
        nextScreen(vc: LoginViewController())
    }

    func goToRegister() {
        nextScreen(vc: LoginViewController())
    }

    private func nextScreen(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

