//
//  FavoritesManager.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 16/5/25.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesKey = "favorites"

    private var favorites: [String: Date] {
        get {
            if let data = UserDefaults.standard.data(forKey: favoritesKey),
               let dict = try? JSONDecoder().decode([String: Date].self, from: data) {
                return dict
            }
            return [:]
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: favoritesKey)
            }
        }
    }

    func isFavorite(_ propertyCode: String) -> Bool {
        favorites[propertyCode] != nil
    }

    func favoritedDate(_ propertyCode: String) -> Date? {
        favorites[propertyCode]
    }

    func toggleFavorite(_ propertyCode: String) {
        var favs = favorites
        if favs[propertyCode] == nil {
            favs[propertyCode] = Date()
        } else {
            favs.removeValue(forKey: propertyCode)
        }
        favorites = favs
    }
}
