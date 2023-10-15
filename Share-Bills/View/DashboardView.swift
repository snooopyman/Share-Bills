//
//  DashboardView.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 15/10/23.
//

import UIKit

final class DashboardView: UIView {

    weak var delegate: NavigationDelegate?

    //MARK: - UI Components
    private lazy var title = createLabel(text: "Summary")

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.adjWhiteBlack
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

//MARK: - Private Methods
extension DashboardView {

    private func setup() {
        addSubviews()
        configureConstraints()
    }

    private func addSubviews() {
        addSubview(title)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 160),
            title.widthAnchor.constraint(equalToConstant: 170),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 80),
        ])
    }

    private func createLabel(text: String) -> CustomLabel {
        return CustomLabel(
            text: text,
            textColor: UIColor.adjSecondary,
            font: UIFont.boldSystemFont(ofSize: 65)
        )
    }
}
