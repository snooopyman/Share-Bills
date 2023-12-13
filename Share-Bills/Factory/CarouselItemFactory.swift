//
//  CarouselItemFactory.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 25/10/23.
//

import UIKit

private enum Titles {
    static let cool = "Cool"
    static let relax = "Relax"
    static let sit = "Sit"
    static let stand = "Stand"
}

private enum Descriptions {
    static let cool = "Description Cool"
    static let relax = "Description Relax"
    static let sit = "Description Sit"
    static let stand = "Description Stand"
}

struct CarouselItemFactory {
    static func createItems() -> [CarouselItem] {
        let itemNames = [(UIImage.cool, Titles.cool.localized, Descriptions.cool.localized),
                         (UIImage.relax,  Titles.relax.localized, Descriptions.relax.localized),
                         (UIImage.sit,  Titles.sit.localized, Descriptions.sit.localized),
                         (UIImage.stand,  Titles.stand.localized, Descriptions.stand.localized)]

        return itemNames.map { (image, title, description) in
            return CarouselItem(image: image, title: title, description: description)
        }
    }
}
