//
//  CarouselItemViewModel.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 13/11/23.
//

import UIKit
import Combine

class CarouselItemViewModel: ObservableObject {
    @Published var image: UIImage
    @Published var title: String
    @Published var description: String

    init(carouselItem: CarouselItem) {
        self.image = carouselItem.image
        self.title = carouselItem.title
        self.description = carouselItem.description
    }
}
