//
//  WelcomeViewController.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 11/10/23.
//

import UIKit

class WelcomeViewController: UIViewController, NavigationDelegate {

    override func loadView() {
        let welcomeView = WelcomeView()
        welcomeView.delegate = self
        self.view = welcomeView
    }

    func navigateTo(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }

}

