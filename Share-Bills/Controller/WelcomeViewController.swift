//
//  WelcomeViewController.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 11/10/23.
//

import UIKit

class WelcomeViewController: UIViewController, NavigationDelegate {

    //MARK: View lifecycle
    override func loadView() {
        let welcomeView = WelcomeView()
        welcomeView.delegate = self
        self.view = welcomeView
    }

    //MARK: - NavigationDelegate methods
    func navigateTo(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

