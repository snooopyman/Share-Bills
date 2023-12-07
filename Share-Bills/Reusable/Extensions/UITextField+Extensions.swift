//
//  UITextField+Extensions.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 7/12/23.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        return NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { notification in
            return (notification.object as? UITextField)?.text ?? ""
        }.eraseToAnyPublisher()
    }
}
