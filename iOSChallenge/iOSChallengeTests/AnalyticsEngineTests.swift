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

    func waitForEvents(count: Int, timeout: TimeInterval = 1.0) {
        let start = Date()
        while testProvider.trackedEvents.count < count && Date().timeIntervalSince(start) < timeout {
            RunLoop.current.run(mode: .default, before: Date().addingTimeInterval(0.01))
        }
    }

    func testTrackAddFavoriteEvent() {
        analytics.trackAddFavorite(propertyCode: "123", from: .listView)
        waitForEvents(count: 1)
        let events = testProvider.trackedEvents
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events.first?.name, "addFavorite")
        XCTAssertEqual(events.first?.properties["propertyCode"] as? String, "123")
        XCTAssertEqual(events.first?.properties["analyticsScreen"] as? String, AnalyticsScreen.listView.rawValue)
        testProvider.trackedEvents = []
    }

    func testTrackRemoveFavoriteEvent() {
        analytics.trackRemoveFavorite(propertyCode: "999", from: .detailView)
        waitForEvents(count: 1)
        let events = testProvider.trackedEvents
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events.first?.name, "removeFavorite")
        XCTAssertEqual(events.first?.properties["propertyCode"] as? String, "999")
        XCTAssertEqual(events.first?.properties["analyticsScreen"] as? String, AnalyticsScreen.detailView.rawValue)
        testProvider.trackedEvents = []
    }

    func testTrackAdClickedEvent() {
        analytics.trackAdClicked(propertyCode: "777")
        waitForEvents(count: 1)
        let events = testProvider.trackedEvents
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events.first?.name, "adClicked")
        XCTAssertEqual(events.first?.properties["propertyCode"] as? String, "777")
        XCTAssertEqual(events.first?.properties["analyticsScreen"] as? String, AnalyticsScreen.listView.rawValue)
        testProvider.trackedEvents = []
    }
}
