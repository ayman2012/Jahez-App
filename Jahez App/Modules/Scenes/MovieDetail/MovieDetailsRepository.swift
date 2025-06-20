//
//  MovieDetailsRepository.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import Combine

protocol MovieDetailsRepositoryProtocol {
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetail, Error>
}

final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    
    private let networkService: NetworkManagerProtocol
    private let cacheService: CacheServiceProtocol
    
    init(networkService: NetworkManagerProtocol = NetworkManager(),
         cacheService: CacheServiceProtocol = CacheService()) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "No base URl Found"
    let APIKay = Bundle.main.object(forInfoDictionaryKey: "APIKay") as? String ?? "No APIKay Found"
    
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetail, Error> {
        let url = URL(string: "https://\(baseURL)/movie/\(id)?api_key=\(APIKay)")!
        return networkService.request(URLRequest(url: url))
    }
}
