//
//  FavoritesManagerTests.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//


import XCTest
@testable import iOSChallenge

class FavoritesManagerTests: XCTestCase {
    let propertyCode = "TEST123"

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "favorites")
    }

    func testToggleFavoriteAddsAndRemovesFavorite() {
        let manager = FavoritesManager.shared

        XCTAssertFalse(manager.isFavorite(propertyCode))

        manager.toggleFavorite(propertyCode)
        XCTAssertTrue(manager.isFavorite(propertyCode))
        XCTAssertNotNil(manager.favoritedDate(propertyCode))

        manager.toggleFavorite(propertyCode)
        XCTAssertFalse(manager.isFavorite(propertyCode))
    }
}
