//
//  MockAPIService.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//

@testable import iOSChallenge

class MockAPIService: APIServiceProtocol {
    func fetchListings(completion: @escaping (Result<[ListItem], Error>) -> Void) {
        // Use sample data
        let item = ListItem(propertyCode: "1", thumbnail: "url", floor: "1", price: 1000, priceInfo: PriceInfoWrapper(price: PriceInfo(amount: 1000, currencySuffix: "€")), propertyType: .flat, operation: .sale, size: 100, exterior: true, rooms: 2, bathrooms: 1, address: "Some St.", province: "Madrid", municipality: "Madrid", district: "Centro", country: "es", neighborhood: "Test", latitude: 0, longitude: 0, description: "desc", multimedia: Multimedia(images: []), features: Features(hasAirConditioning: false, hasBoxRoom: false), parkingSpace: nil)
        completion(.success([item]))
    }
    func fetchAdDetail(adId: Int, completion: @escaping (Result<AdDetail, Error>) -> Void) {
        // Implement as needed
    }
}
