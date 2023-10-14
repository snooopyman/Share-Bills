//
//  CustomButton.swift
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
        super.init(coder: coder)
        configure()
    }

    public convenience init(backgroundColor: UIColor?, title: String, font: UIFont?, titleColor: UIColor?, borderWidth: CGFloat? = nil, cornerRadious: CGFloat? = nil, action: UIAction) {
        self.init(type: .system)
        self.backgroundColor = backgroundColor ?? .clear
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        if let borderWidth = borderWidth, borderWidth > 0 {
            self.layer.borderWidth = borderWidth
        }
        if let cornerRadious = cornerRadious, cornerRadious > 0 {
            self.layer.cornerRadius = cornerRadious
        }
        self.addAction(action, for: .touchUpInside)
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
