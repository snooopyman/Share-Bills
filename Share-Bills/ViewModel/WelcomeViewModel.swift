//
//  WelcomeViewModel.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 29/11/23.
//

import UIKit
import Combine

final class WelcomeViewModel {
    @Published var carouselItems: [CarouselItem] = CarouselItemFactory.createItems()
    var registerButtonTapped = PassthroughSubject<Void, Never>()
    var loginButtonTapped = PassthroughSubject<Void, Never>()
}
