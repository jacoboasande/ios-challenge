//
//  AnalyticsEngineTests.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//


import XCTest
@testable import iOSChallenge

class AnalyticsEngineTests: XCTestCase {

    var analytics: AnalyticsEngine!
    var testProvider: TestAnalyticsProvider!

    override func setUp() {
        super.setUp()
        testProvider = TestAnalyticsProvider()
        analytics = AnalyticsEngine(provider: testProvider)
    }

    func testTrackAddFavoriteEvent() {
        analytics.trackAddFavorite(propertyCode: "123", from: .listView)

        let expectation = self.expectation(description: "Wait for async")
        DispatchQueue.global(qos: .background).async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        let events = self.testProvider.trackedEvents
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events.first?.name, "addFavorite")
        XCTAssertEqual(events.first?.properties["propertyCode"] as? String, "123")
        XCTAssertEqual(events.first?.properties["analyticsScreen"] as? String, AnalyticsScreen.listView.rawValue)
    }

    func testTrackRemoveFavoriteEvent() {
        analytics.trackRemoveFavorite(propertyCode: "999", from: .detailView)

        let expectation = self.expectation(description: "Wait for async")
        DispatchQueue.global(qos: .background).async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        let events = self.testProvider.trackedEvents
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events.first?.name, "removeFavorite")
        XCTAssertEqual(events.first?.properties["propertyCode"] as? String, "999")
        XCTAssertEqual(events.first?.properties["analyticsScreen"] as? String, AnalyticsScreen.detailView.rawValue)
    }
}

