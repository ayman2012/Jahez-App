//
//  MovieRepository.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Combine

// MARK: - MovieRepositoryProtocol
protocol MovieRepositoryProtocol {
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[MovieDTO]?, Error>
    func fetchGenres() -> AnyPublisher<[GenreDTO]?, Error>
}

// MARK: - MovieRepository
final class MovieRepository: MovieRepositoryProtocol {

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

    // MARK: - MovieRepositoryProtocol Implementation
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[MovieDTO]?, Error> {
        if ReachabilityService.shared.isConnected {

            guard let urlRequest = buildTrendingMoviesRequest(page: page) else {
                return Fail(error: NetworkFailure.generalFailure)
                    .eraseToAnyPublisher()
            }

            return networkService.request(urlRequest)
                .map { (response: MovieListResponseDTO) in
                    let movies = response.results
                    self.cacheService.save(movies, forKey: "\(CacheKeys.trendingMoviesPage.rawValue)\(page)")
                    return movies
                }
                .eraseToAnyPublisher()

        } else {
            let cached = cacheService.load(forKey: "\(CacheKeys.trendingMoviesPage.rawValue)\(page)", type: [MovieDTO].self)
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    func fetchGenres() -> AnyPublisher<[GenreDTO]?, Error> {
        if ReachabilityService.shared.isConnected {
            var components = URLComponents(string: "https://\(baseURL)/genre/movie/list")!
            components.queryItems = [URLQueryItem(name: "api_key", value: APIKay)]
            let request = URLRequest(url: components.url!)
            return networkService.request(request)
                .map { (response: GenreResponseDTO) in
                    let genres = response.genres
                    self.cacheService.save(genres, forKey: CacheKeys.movieGenres.rawValue)
                    return genres
                }
                .eraseToAnyPublisher()
        } else {
            let cached = cacheService.load(forKey: CacheKeys.movieGenres.rawValue, type: [GenreDTO].self)
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    private func buildTrendingMoviesRequest(page: Int) -> URLRequest? {
        var components = URLComponents(string: "https://\(baseURL)/discover/movie")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: APIKay),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        guard let url = components.url else { return nil}
        return URLRequest(url: url)
    }
}
