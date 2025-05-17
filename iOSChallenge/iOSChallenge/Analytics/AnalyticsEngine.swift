//
//  AnalyticsEngine.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//

import Foundation

final class AnalyticsEngine {
    static let shared = AnalyticsEngine()
    private let provider: AnalyticsProvider

    init(provider: AnalyticsProvider = IdealistaAnalyticsProvider()) {
        self.provider = provider
    }

    func trackEvent(name: String, properties: [String: Any]) {
        provider.trackEvent(name: name, properties: properties)
    }
}
