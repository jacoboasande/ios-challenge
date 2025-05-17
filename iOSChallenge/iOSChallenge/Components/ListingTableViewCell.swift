//
//  ListingTableViewCell.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ListingCell"
    weak var delegate: ListingCellDelegate?

    // MARK: Views
    private let thumbnailImageView = UIImageView()
    private let addressLabel = UILabel()
    private let secondAddressLabel = UILabel()
    private let priceLabel = UILabel()
    private let infoLabel = UILabel()
    private let secondInfoLabel = UILabel()
    private let expandButton = UIButton(type: .system)
    private let imagesCollectionView: UICollectionView
    private let favoriteButton = UIButton(type: .system)

    private var images: [String] = []
    private var isExpanded = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 100, height: 80)
        imagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupViews() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 8
        addressLabel.font = .boldSystemFont(ofSize: 16)
        addressLabel.textColor = .label
        secondAddressLabel.font = .boldSystemFont(ofSize: 16)
        secondAddressLabel.textColor = .secondaryLabel
        priceLabel.font = .systemFont(ofSize: 14)
        priceLabel.textColor = .systemGreen
        infoLabel.font = .systemFont(ofSize: 12)
        infoLabel.textColor = .secondaryLabel
        infoLabel.numberOfLines = 1
        secondInfoLabel.font = .systemFont(ofSize: 12)
        secondInfoLabel.textColor = .secondaryLabel
        secondInfoLabel.numberOfLines = 1

        expandButton.setTitle("▼", for: .normal)
        expandButton.setTitleColor(.white, for: .normal)

        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.setTitle("▼", for: .normal)
        expandButton.setTitleColor(.white, for: .normal)
        expandButton.backgroundColor = .systemBlue
        expandButton.layer.cornerRadius = 15
        expandButton.layer.borderWidth = 1
        expandButton.layer.borderColor = UIColor.white.cgColor
        expandButton.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)
        expandButton.accessibilityIdentifier = "expandButton"


        favoriteButton.tintColor = .systemYellow
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        favoriteButton.accessibilityIdentifier = "starButton"

        imagesCollectionView.isHidden = true
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ImgCell")
        imagesCollectionView.isAccessibilityElement = true
        imagesCollectionView.accessibilityIdentifier = "carouselCollectionView"

        contentView.backgroundColor = .systemBackground
        backgroundColor = .clear

        let textStack = UIStackView(arrangedSubviews: [addressLabel, secondAddressLabel, priceLabel, infoLabel, secondInfoLabel])
        textStack.axis = .vertical
        textStack.spacing = 4

        let topRow = UIStackView(arrangedSubviews: [thumbnailImageView, textStack, favoriteButton, expandButton])
        topRow.axis = .horizontal
        topRow.alignment = .center
        topRow.spacing = 12

        let mainStack = UIStackView(arrangedSubviews: [topRow, imagesCollectionView])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor),

            expandButton.widthAnchor.constraint(equalToConstant: 30),

            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imagesCollectionView.heightAnchor.constraint(equalToConstant: 0)
        ])
    }

    @objc private func didTapExpand() {
        delegate?.listingCell(self, didToggleExpanded: !isExpanded)
    }

    @objc private func didTapFavorite() {
        delegate?.listingCellDidTapFavorite(self)
    }


    func setExpanded(_ expand: Bool) {
        isExpanded = expand
        expandButton.setTitle(expand ? "▲" : "▼", for: .normal)
        imagesCollectionView.isHidden = !expand
        imagesCollectionView.layoutIfNeeded()
        expandButton.backgroundColor = expand ? .systemGray3 : .systemBlue
        expandButton.layer.borderColor = UIColor.systemBackground.cgColor
        if expand {
            imagesCollectionView.accessibilityLabel = "carouselCollectionView"
            self.accessibilityIdentifier = "expandedCell"
        } else {
            imagesCollectionView.accessibilityLabel = nil
            self.accessibilityIdentifier = nil
        }


        if let heightConstraint = imagesCollectionView.constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = expand ? 80 : 0
        }
    }

    func configure(with listing: ListItem, isExpanded: Bool, isFavorite: Bool) {
        addressLabel.text = "\(listing.propertyType.localized) en \(listing.address)"
        secondAddressLabel.text = "\(listing.province) - \(listing.neighborhood)"
        priceLabel.text = formattedPrice(listing.price)
        infoLabel.text = "📄 \(listing.operation.localized)"
        let hasParkingSpace = listing.parkingSpace?.hasParkingSpace ?? false
        secondInfoLabel.text = "🏠 \(listing.size) m² · 🛏 \(listing.rooms) · 🛁 \(listing.bathrooms)\(hasParkingSpace ? " - Parking Incl." : "")"
        thumbnailImageView.setImage(from: listing.thumbnail)

        images = listing.multimedia.images.map { $0.url }
        imagesCollectionView.reloadData()

        setExpanded(isExpanded)

        let starName = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: starName), for: .normal)
    }

    private func formattedPrice(_ price: Double) -> String {
        let f = NumberFormatter(); f.numberStyle = .currency; f.maximumFractionDigits = 0; f.currencySymbol = "€"
        return f.string(from: NSNumber(value: price)) ?? "\(price) €"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.cancelImageLoad()
        thumbnailImageView.image = nil
        images = []
        imagesCollectionView.reloadData()
        setExpanded(false)
    }
}

// MARK: – UICollectionViewDataSource

extension ListingTableViewCell: UICollectionViewDataSource {
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    func collectionView(_ cv: UICollectionView, cellForItemAt idx: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "ImgCell", for: idx)
        let urlStr = images[idx.item]
        let iv = UIImageView(frame: cell.contentView.bounds)
        iv.contentMode = .scaleAspectFill; iv.clipsToBounds = true
        iv.setImage(from: urlStr)
        cell.contentView.addSubview(iv)
        return cell
    }
}

protocol ListingCellDelegate: AnyObject {
    func listingCell(_ cell: ListingTableViewCell, didToggleExpanded expanded: Bool)
    func listingCellDidTapFavorite(_ cell: ListingTableViewCell)
}
