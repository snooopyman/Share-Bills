//
//  CustomImageview.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 16/10/23.
//

import UIKit

class CustomImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    public convenience init(image: UIImage?, contentMode: UIView.ContentMode, backgroundColor: UIColor?, cornerRadius: CGFloat? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
        self.init(frame: .zero)
        self.image = image
        self.contentMode = contentMode
        self.backgroundColor = backgroundColor ?? .clear
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        if let borderWidth = borderWidth, let borderColor = borderColor {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
        }
    }

    private func configure() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
