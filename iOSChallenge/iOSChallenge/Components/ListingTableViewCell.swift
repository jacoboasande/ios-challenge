//
//  ListingTableViewCell.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ListingCell"

    private let thumbnailImageView = UIImageView()
    private let addressLabel = UILabel()
    private let secondAddressLabel = UILabel()

    private let priceLabel = UILabel()
    private let infoLabel = UILabel()
    private let secondInfoLabel = UILabel()
    private let containerStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        addressLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondAddressLabel.font = UIFont.boldSystemFont(ofSize: 16)

        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = .systemGreen

        infoLabel.font = UIFont.systemFont(ofSize: 12)
        infoLabel.textColor = .darkGray
        infoLabel.numberOfLines = 1
        secondInfoLabel.font = UIFont.systemFont(ofSize: 12)
        secondInfoLabel.textColor = .darkGray
        secondInfoLabel.numberOfLines = 1

        let textStack = UIStackView(arrangedSubviews: [addressLabel, secondAddressLabel, priceLabel, infoLabel, secondInfoLabel])
        textStack.axis = .vertical
        textStack.spacing = 4

        containerStack.axis = .horizontal
        containerStack.alignment = .center
        containerStack.spacing = 12
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.addArrangedSubview(thumbnailImageView)
        containerStack.addArrangedSubview(textStack)

        contentView.addSubview(containerStack)

        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        thumbnailImageView.cancelImageLoad()
    }

    func configure(with listing: ListItem) {
        addressLabel.text = "\(listing.propertyType.localized) en \(listing.address)"
        secondAddressLabel.text = "\(listing.province) - \(listing.neighborhood)"

        priceLabel.text = formattedPrice(listing.price)
        infoLabel.text = "📄 \(listing.operation.localized)"
        secondInfoLabel.text = "🏠 \(listing.size) m² · 🛏 \(listing.rooms) · 🛁 \(listing.bathrooms)"

        thumbnailImageView.setImage(from: listing.thumbnail, placeholder: UIImage(systemName: "photo"))
    }

    private func formattedPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "€"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: price)) ?? "\(price) €"
    }
}

