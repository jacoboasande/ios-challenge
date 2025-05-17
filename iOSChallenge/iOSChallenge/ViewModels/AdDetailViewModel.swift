//
//  AdDetailViewModel 2.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 16/5/25.
//

import Foundation

class AdDetailViewModel: ObservableObject {
    let listItem: ListItem
    let detail: AdDetail
    var isFavorite: Bool {
        FavoritesManager.shared.isFavorite(propertyCode)
    }
    var propertyCode: String { listItem.propertyCode }

    init(listItem: ListItem, detail: AdDetail) {
        self.listItem = listItem
        self.detail = detail
    }

    var favoritedDateString: String? {
        guard let date = FavoritesManager.shared.favoritedDate(propertyCode) else { return nil }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    func toggleFavorite() {
        if isFavorite {
            AnalyticsEngine.shared.trackRemoveFavorite(propertyCode: propertyCode, from: .detailView)
        } else {
            AnalyticsEngine.shared.trackAddFavorite(propertyCode: propertyCode, from: .detailView)
        }
        FavoritesManager.shared.toggleFavorite(propertyCode)
        objectWillChange.send()
    }

    var titleLine1: String {
        "\(detail.extendedPropertyType.localized) en \(listItem.address)"
    }
    var titleLine2: String {
        "\(listItem.province) - \(listItem.neighborhood)"
    }
}
