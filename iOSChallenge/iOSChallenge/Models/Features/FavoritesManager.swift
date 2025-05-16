//
//  FavoritesManager.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 16/5/25.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favoritePropertyCodes"

    private init() {}

    func allFavorites() -> [String] {
        UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }

    func isFavorite(_ propertyCode: String) -> Bool {
        allFavorites().contains(propertyCode)
    }

    func addFavorite(_ propertyCode: String) {
        var favorites = allFavorites()
        guard !favorites.contains(propertyCode) else { return }
        favorites.append(propertyCode)
        UserDefaults.standard.setValue(favorites, forKey: favoritesKey)
    }

    func removeFavorite(_ propertyCode: String) {
        var favorites = allFavorites()
        favorites.removeAll { $0 == propertyCode }
        UserDefaults.standard.setValue(favorites, forKey: favoritesKey)
    }

    func toggleFavorite(_ propertyCode: String) {
        if isFavorite(propertyCode) {
            removeFavorite(propertyCode)
        } else {
            addFavorite(propertyCode)
        }
    }
}
