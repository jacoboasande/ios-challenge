//
//  AdDetail.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import Foundation

struct AdDetail: Codable {
    let adid: Int
    let price: Double
    let priceInfo: PriceInfo
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: Multimedia
    let propertyComment: String
    let ubication: Location
    let country: String
    let extra: MoreCharacteristics
    let energyCertification: EnergyCertification
}
