//
//  stringLocalize.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 15/10/23.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
