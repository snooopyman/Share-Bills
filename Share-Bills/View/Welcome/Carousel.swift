//
//  Carousel.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 17/10/23.
//

import UIKit
import Combine

class Carousel: UIView {

    //MARK: - Properties
    private var welcomeViewModel: WelcomeViewModel
    private var cancellables = Set<AnyCancellable>()
    private var pageControl: UIPageControl?

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CarouselLayout())
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CarouselItemCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    //MARK: - Initializers
    public init(viewModel: WelcomeViewModel) {
        self.welcomeViewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupPageControl(_ pageControl: UIPageControl) {
        self.pageControl = pageControl
        pageControl.numberOfPages = welcomeViewModel.carouselItems.count
        addSubview(pageControl)
    }
}

//MARK: - Private methods
private extension Carousel {
    func setupView() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        welcomeViewModel.$carouselItems
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension Carousel: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return welcomeViewModel.carouselItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarouselItemCell

        let item = welcomeViewModel.carouselItems[indexPath.row]
        cell.imageView.image = item.image
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description

        return cell
    }
}

//MARK: - UIScrollViewDelegate methods
extension Carousel: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl?.currentPage = page
    }
}
