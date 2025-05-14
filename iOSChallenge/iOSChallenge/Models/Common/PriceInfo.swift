//
//  PriceInfo.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import Foundation

struct PriceInfoWrapper: Codable {
    let price: PriceInfo
}

struct PriceInfo: Codable {
    let amount: Double
    let currencySuffix: String
}
