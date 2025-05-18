//
//  AnalyticsProvider.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//

protocol AnalyticsProvider: AnyObject {
    func trackEvent(name: String, properties: [String: Any])
}
