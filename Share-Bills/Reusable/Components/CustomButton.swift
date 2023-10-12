//
//  Button.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 12/10/23.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public convenience init(backgroundColor: UIColor?, title: String, font: UIFont?, titleColor: UIColor?, borderWidth: Int, action: UIAction) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor ?? .clear
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.layer.borderWidth = 1
        self.addAction(action, for: .touchUpInside)
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
