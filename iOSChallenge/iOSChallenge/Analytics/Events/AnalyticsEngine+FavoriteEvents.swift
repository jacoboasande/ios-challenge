//
//  AnalyticsEngine+FavoriteEvents.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//

import Foundation

extension AnalyticsEngine {
    func trackAddFavorite(propertyCode: String, from screen: AnalyticsScreen) {
        let props: [String: Any] = [
            "propertyCode": propertyCode,
            "analyticsScreen": screen.rawValue
        ]
        DispatchQueue.global(qos: .background).async {
            self.trackEvent(name: "addFavorite", properties: props)
        }
    }

    func trackRemoveFavorite(propertyCode: String, from screen: AnalyticsScreen) {
        let props: [String: Any] = [
            "propertyCode": propertyCode,
            "analyticsScreen": screen.rawValue
        ]
        DispatchQueue.global(qos: .background).async {
            self.trackEvent(name: "removeFavorite", properties: props)
        }
    }
}
