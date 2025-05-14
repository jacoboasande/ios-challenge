//
//  ListItem.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import Foundation

struct ListItem: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceInfoWrapper
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: Multimedia
    let features: Features
}
