//
//  TestAnalyticsProvider.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//

@testable import iOSChallenge

class TestAnalyticsProvider: AnalyticsProvider {
    var trackedEvents: [(name: String, properties: [String: Any])] = []

    func trackEvent(name: String, properties: [String: Any]) {
        trackedEvents.append((name, properties))
    }
}
