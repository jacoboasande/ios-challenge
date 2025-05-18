//
//  AnalyticsEngine+AdClickedEvent.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 18/5/25.
//
import Foundation

extension AnalyticsEngine {
    func trackAdClicked(propertyCode: String) {
        let props: [String: Any] = [
            "propertyCode": propertyCode,
            "analyticsScreen": AnalyticsScreen.listView.rawValue
        ]
        DispatchQueue.global(qos: .background).async {
            self.trackEvent(name: "adClicked", properties: props)
        }
    }
}
