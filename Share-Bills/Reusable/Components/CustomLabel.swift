//
//  CustomLabel.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 14/10/23.
//

import UIKit

class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    public convenience init(text: String, textColor: UIColor, font: UIFont) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
