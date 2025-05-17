//
//  iOSChallengeUITests.swift
//  iOSChallengeUITests
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import XCTest

final class iOSChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
    }

    func testListingTableAndCellTap() {
        let app = XCUIApplication()
        app.launch()

        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "The first listing cell should exist")

        firstCell.tap()

        let predicate = NSPredicate(format: "label CONTAINS[c] %@", "Habitaciones")
        let habitacionesLabel = app.staticTexts.containing(predicate).firstMatch
        let exists = habitacionesLabel.waitForExistence(timeout: 2)
        XCTAssertTrue(exists, "Detail view should show a Habitaciones label")
    }

    func testPullToRefreshReloadsList() {
        let app = XCUIApplication()
        app.launch()

        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 4))

        let start = table.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let finish = table.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
        start.press(forDuration: 0.01, thenDragTo: finish)

        sleep(1)

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First cell should still exist after refresh")
    }

    func testFavoriteStarInList() {
        let app = XCUIApplication()
        app.launch()

        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3))

        let starButton = firstCell.buttons["starButton"]
        XCTAssertTrue(starButton.exists, "Star button should be visible in the cell")

        starButton.tap()
        sleep(1)
        starButton.tap()
    }

    func testBackNavigationFromDetail() {
        let app = XCUIApplication()
        app.launch()
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3))
        firstCell.tap()

        app.navigationBars.buttons.element(boundBy: 0).tap()

        XCTAssertTrue(app.tables.firstMatch.exists)
    }

    func testCarouselVisibleAfterExpand() {
        let app = XCUIApplication()
        app.launch()

        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3), "First cell should appear")

        let expandButton = firstCell.buttons["expandButton"]
        XCTAssertTrue(expandButton.exists, "Expand button should be present")
        expandButton.tap()

        let carousel = firstCell.collectionViews["carouselCollectionView"]
        XCTAssertTrue(carousel.waitForExistence(timeout: 2), "Carousel should appear after expand")
    }
}
