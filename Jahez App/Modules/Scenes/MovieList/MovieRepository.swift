//
//  MovieRepository.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[Movie], Error>
    func fetchGenres() -> AnyPublisher<[Genre], Error>
}

final class MovieRepository: MovieRepositoryProtocol {
    
    private let networkService: NetworkManagerProtocol
    private let cacheService: CacheServiceProtocol
    
    init(networkService: NetworkManagerProtocol = NetworkManager(),
         cacheService: CacheServiceProtocol = CacheService()) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "No base URl Found"
    let APIKay = Bundle.main.object(forInfoDictionaryKey: "APIKay") as? String ?? "No APIKay Found"
    
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        
        if let cached = cacheService.load(forKey: "\(CacheKeys.trendingMoviesPage.rawValue)\(page)", type: [Movie].self) {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        var components = URLComponents(string: "https://\(baseURL)/discover/movie")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: APIKay),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        let request = URLRequest(url: components.url!)
        return networkService.request(request)
            .map { (response: MovieListResponse) in
                let movies = response.results
                self.cacheService.save(movies, forKey: "\(CacheKeys.trendingMoviesPage.rawValue)\(page)")
                return movies
            }
            .eraseToAnyPublisher()
    }
    
    func fetchGenres() -> AnyPublisher<[Genre], Error> {
        
        if let cached = cacheService.load(forKey: CacheKeys.movieGenres.rawValue, type: [Genre].self) {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        var components = URLComponents(string: "https://\(baseURL)/genre/movie/list")!
        components.queryItems = [URLQueryItem(name: "api_key", value: APIKay)]
        let request = URLRequest(url: components.url!)
        return networkService.request(request)
            .map { (response: GenreResponse) in
                let genres = response.genres
                self.cacheService.save(genres, forKey: CacheKeys.movieGenres.rawValue)
                return genres
            }
            .eraseToAnyPublisher()
    }
}
