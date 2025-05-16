//
//  APIServiceProtocol.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetchListings(completion: @escaping (Result<[ListItem], Error>) -> Void)
    func fetchAdDetail(adId: Int, completion: @escaping (Result<AdDetail, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    private let baseURL = "https://idealista.github.io/ios-challenge"
    private var cachedAdDetail: AdDetail?

    func fetchListings(completion: @escaping (Result<[ListItem], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/list.json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let listings = try JSONDecoder().decode([ListItem].self, from: data)
                completion(.success(listings))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchAdDetail(adId: Int, completion: @escaping (Result<AdDetail, Error>) -> Void) {
           if let cached = cachedAdDetail {
               completion(.success(cached))
               return
           }

           let url = URL(string: "\(baseURL)/detail.json")!
           let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }

               guard let data = data else {
                   completion(.failure(NSError(domain: "Invalid data", code: -1, userInfo: nil)))
                   return
               }

               do {
                   let adDetail = try JSONDecoder().decode(AdDetail.self, from: data)
                   self?.cachedAdDetail = adDetail
                   completion(.success(adDetail))
               } catch {
                   completion(.failure(error))
               }
           }
           task.resume()
       }
}
