//
//  Carousel.swift
//  Share-Bills
//
//  Created by Jesús Armando Cáceres Vilchez on 17/10/23.
//

import UIKit

class Carousel: UIView {

    //MARK: - Properties
    var items: [CarouselItem] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var pageControl: UIPageControl?

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CarouselLayout()
    )

    //MARK: - Initializers
    public init(items: [CarouselItem]) {
        self.items = items
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupPageControl(_ pageControl: UIPageControl) {
        self.pageControl = pageControl
        pageControl.numberOfPages = items.count
    }
}

//MARK: - Private methods
private extension Carousel {
    func setupView() {
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)

        collectionView.register(CarouselItemCell.self, forCellWithReuseIdentifier: "cell")

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension Carousel: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarouselItemCell

        let item = items[indexPath.row]
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
