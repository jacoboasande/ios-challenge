//
//  ListViewModelTests.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//

import XCTest
import Combine
@testable import iOSChallenge

class ListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testFetchListings() {
        class MockAPIService: APIServiceProtocol {
            func fetchListings(completion: @escaping (Result<[ListItem], Error>) -> Void) {
                let dummy = ListItem(
                    propertyCode: "1",
                    thumbnail: "",
                    floor: "1",
                    price: 1000,
                    priceInfo: .init(price: .init(amount: 1000, currencySuffix: "€")),
                    propertyType: .flat,
                    operation: .sale,
                    size: 99.0,
                    exterior: true,
                    rooms: 2,
                    bathrooms: 1,
                    address: "Fake St.",
                    province: "Madrid",
                    municipality: "Madrid",
                    district: "Centro",
                    country: "es",
                    neighborhood: "Centro",
                    latitude: 0.0,
                    longitude: 0.0,
                    description: "desc",
                    multimedia: Multimedia(images: []),
                    features: Features(hasAirConditioning: false, hasBoxRoom: false),
                    parkingSpace: nil
                )
                completion(.success([dummy]))
            }
            func fetchAdDetail(adId: Int, completion: @escaping (Result<AdDetail, Error>) -> Void) { }
        }

        let vm = ListViewModel(apiService: MockAPIService())
        let exp = expectation(description: "Listings Updated")

        vm.$listings
            .dropFirst()
            .sink { listings in
                XCTAssertEqual(listings.count, 1)
                XCTAssertEqual(listings.first?.propertyCode, "1")
                exp.fulfill()
            }
            .store(in: &cancellables)

        vm.fetchListings()
        waitForExpectations(timeout: 1)
    }
}

