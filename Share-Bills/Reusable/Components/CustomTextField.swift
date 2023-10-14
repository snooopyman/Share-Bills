//
//  CustomTextField.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 14/10/23.
//

import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    public convenience init(text: String, placeholder: String, isPassword: Bool = false, font: UIFont, backgroundColor: UIColor, borderWidth: CGFloat? = nil, borderColor: UIColor, cornerRadius: CGFloat? = nil) {
        self.init()
        self.text = text
        self.isSecureTextEntry = isPassword
        self.placeholder = placeholder
        self.font = font
        self.backgroundColor = backgroundColor
        if let borderWidth = borderWidth, borderWidth > 0 {
            self.layer.borderWidth = borderWidth
        }
        self.layer.borderColor = borderColor.cgColor
        if let cornerRadius = cornerRadius, cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
        }
    }

    private func configure() {
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
