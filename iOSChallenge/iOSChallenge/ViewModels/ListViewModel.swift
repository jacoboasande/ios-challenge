//
//  ListingViewModel.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var listings: [ListItem] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchListings() {
        isLoading = true
        error = nil
        
        apiService.fetchListings { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let listings):
                    self.listings = listings
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }

    func isFavorite(propertyCode: String) -> Bool {
        FavoritesManager.shared.isFavorite(propertyCode)
    }

    func toggleFavorite(propertyCode: String) {
        FavoritesManager.shared.toggleFavorite(propertyCode)
        objectWillChange.send()
    }
}
