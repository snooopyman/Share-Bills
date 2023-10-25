//
//  CarouselItemCell.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 18/10/23.
//

import UIKit

class CarouselItemCell: UICollectionViewCell {

    //MARK: - Properties
    var item: CarouselItem? {
        didSet {
            if let item = item {
                imageView.image = item.image
                titleLabel.text = item.title
                descriptionLabel.text = item.description
            }
        }
    }

    let imageView: CustomImageView = CustomImageView(image: nil, contentMode: .scaleAspectFill, backgroundColor: .clear, cornerRadius: 8)
    let titleLabel: CustomLabel = CustomLabel(text: "", textColor: UIColor.adjBlackWhite, font: UIFont.boldSystemFont(ofSize: 20))
    let descriptionLabel: CustomLabel = CustomLabel(text: "", textColor: .gray, font: UIFont.systemFont(ofSize: 15))

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CarouselItemCell {

    //MARK: - Private methods
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 350),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }
}
