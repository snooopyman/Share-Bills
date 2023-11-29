//
//  CarouselViewModel.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 13/11/23.
//

import Foundation

class CarouselViewModel: ObservableObject {
    @Published var carouselItems: [CarouselItemViewModel] = []

    init() {
        self.carouselItems = CarouselItemFactory.createItems().map { CarouselItemViewModel(carouselItem: $0) }
    }
}
