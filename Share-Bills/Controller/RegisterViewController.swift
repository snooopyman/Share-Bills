//
//  RegisterViewController.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 14/10/23.
//

import UIKit

class RegisterViewController: UIViewController, NavigationDelegate {

    override func loadView() {
        let registerView = RegisterView()
        registerView.delegate = self
        self.view = registerView
    }

    func navigateTo(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
