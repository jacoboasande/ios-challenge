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
    @Published var isFavorite: Bool


    init(listItem: ListItem, detail: AdDetail) {
        self.listItem = listItem
        self.detail = detail
        self.isFavorite = FavoritesManager.shared.isFavorite(listItem.propertyCode)
    }

    func toggleFavorite() {
        FavoritesManager.shared.toggleFavorite(listItem.propertyCode)
        isFavorite = FavoritesManager.shared.isFavorite(listItem.propertyCode)
        objectWillChange.send()
    }

    var titleLine1: String {
        "\(detail.extendedPropertyType.localized) en \(listItem.address)"
    }
    var titleLine2: String {
        "\(listItem.province) - \(listItem.neighborhood)"
    }
}
