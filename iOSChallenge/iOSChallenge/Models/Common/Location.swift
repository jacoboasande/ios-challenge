//
//  Location.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import Foundation

struct Location: Codable, Identifiable {
    let latitude: Double
    let longitude: Double
    var id: String { "\(latitude),\(longitude)" }
}
