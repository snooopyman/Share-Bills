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
        fatalError("init(coder:) has not been implemented.")
    }

    public convenience init(title: String, font: UIFont?, titleColor: UIColor?,backgroundColor: UIColor?, borderWidth: CGFloat? = nil, borderColor: CGColor? = nil, cornerRadious: CGFloat? = nil, action: UIAction) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor ?? .clear
        if let borderWidth = borderWidth, borderWidth > 0 {
            self.layer.borderWidth = borderWidth
        }
        self.layer.borderColor = borderColor
        if let cornerRadius = cornerRadious, cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
        }
        self.addAction(action, for: .touchUpInside)
    }

    public convenience init(title: String, font: UIFont? = nil, titleColor: UIColor? = nil, backgroundColor: UIColor? = nil, borderWidth: CGFloat? = nil, borderColor: CGColor? = nil, cornerRadius: CGFloat? = nil, filled: Bool = false, action: @escaping () -> Void) {
            self.init(type: .system)
            var configuration = UIButton.Configuration.gray()
            if filled {
                configuration = UIButton.Configuration.filled()
                configuration.baseBackgroundColor = backgroundColor ?? .systemBlue
            }
            configuration.title = title
            self.configuration = configuration
            self.translatesAutoresizingMaskIntoConstraints = false
            self.titleLabel?.font = font
            self.setTitleColor(titleColor, for: .normal)
            if let borderWidth = borderWidth, borderWidth > 0 {
                self.layer.borderWidth = borderWidth
            }
            self.layer.borderColor = borderColor
            if let cornerRadius = cornerRadius, cornerRadius > 0 {
                self.layer.cornerRadius = cornerRadius
            }
            self.addAction(UIAction(handler: { _ in action() }), for: .touchUpInside)
        }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
