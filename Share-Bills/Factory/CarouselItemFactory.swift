//
//  CarouselItemFactory.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 25/10/23.
//

import UIKit

enum Titles {
    static let cool = "Cool"
    static let relax = "Relax"
    static let sit = "Sit"
    static let stand = "Stand"
}

enum Descriptions {
    static let cool = "Descripción Cool"
    static let relax = "Descripción relax"
    static let sit = "Descripción sit"
    static let stand = "Descripción stand"
}

struct CarouselItemFactory {
    static func createItems() -> [CarouselItem] {
        let itemNames = [(UIImage.cool, Titles.cool, Descriptions.cool),
                         (UIImage.relax,  Titles.relax, Descriptions.relax),
                         (UIImage.sit,  Titles.sit, Descriptions.sit),
                         (UIImage.stand,  Titles.stand, Descriptions.stand)]

        return itemNames.map { (image, title, description) in
            return CarouselItem(image: image, title: title, description: description)
        }
    }
}
