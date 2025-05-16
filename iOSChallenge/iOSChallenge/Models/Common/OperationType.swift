//
//  OperationType.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 16/5/25.
//

import Foundation

enum OperationType: String, Codable {
    case sale
    case rent

    var localized: String {
        return NSLocalizedString("operationType.\(rawValue)", comment: "")
    }
}
