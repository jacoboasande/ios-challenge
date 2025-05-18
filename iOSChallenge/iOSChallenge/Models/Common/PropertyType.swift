//
//  PropertyType.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 16/5/25.
//

import Foundation

enum PropertyType: String, Codable {
    case flat
    case house

    var localized: String {
        return NSLocalizedString("propertyType.\(rawValue)", comment: "")
    }
}
