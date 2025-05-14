//
//  AdDetailViewModel.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import Foundation

class AdDetailViewModel {
    @Published var adDetail: AdDetail?
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchAdDetail(adId: Int) {
        isLoading = true
        error = nil
        
        apiService.fetchAdDetail(adId: adId) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let adDetail):
                    self.adDetail = adDetail
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
}
