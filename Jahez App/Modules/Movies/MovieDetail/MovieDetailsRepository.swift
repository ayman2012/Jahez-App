//
//  MovieDetailsRepository.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import Combine

// MARK: - MovieDetailsRepositoryProtocol
protocol MovieDetailsRepositoryProtocol {
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetailDTO?, Error>
}

// MARK: - MovieDetailsRepository
final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {

    // MARK: - Properties
    private let networkService: NetworkManagerProtocol
    private let cacheService: CacheServiceProtocol
    private let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "No base URl Found"
    private let APIKay = Bundle.main.object(forInfoDictionaryKey: "APIKay") as? String ?? "No APIKay Found"

    // MARK: - initialization
    init(networkService: NetworkManagerProtocol = NetworkManager(),
         cacheService: CacheServiceProtocol = CacheService()) {
        self.networkService = networkService
        self.cacheService = cacheService
    }

    // MARK: - MovieDetailsRepositoryProtocol Implementation
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetailDTO?, Error> {

        if ReachabilityService.shared.isConnected {

            let url = URL(string: "https://\(baseURL)/movie/\(id)?api_key=\(APIKay)")!
            return networkService.request(URLRequest(url: url))
                .map { (response: MovieDetailDTO) in
                    self.cacheService.save(response, forKey: CacheKeys.movieDetails.rawValue.appending("\(id)"))
                    return response
                }
                .eraseToAnyPublisher()
        } else {
            let cached = cacheService.load(forKey: CacheKeys.movieDetails.rawValue.appending("\(id)"), type: MovieDetailDTO.self)
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
