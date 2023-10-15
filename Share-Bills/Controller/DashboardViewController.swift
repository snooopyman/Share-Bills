//
//  DashboardViewController.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 14/10/23.
//

import UIKit

class DashboardViewController: UIViewController {

    override func loadView() {
        let dashboardView = DashboardView()
        self.view = dashboardView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
