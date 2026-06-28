//
//  MovieListMockRepo.swift
//  Jahez AppTests
//
//  Created by Ayman Fathy on 22/06/2025.
//

import Foundation
import Combine
@testable import Jahez_App

final class MovieListMockRepo: MovieListRepositoryProtocol {
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[MovieDTO]?, Error> {
        return Just([MovieDTO.mock])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchGenres() -> AnyPublisher<[GenreDTO]?, Error> {
        return Just(GenreDTO.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

final class MovieListMockRepoWithFailure: MovieListRepositoryProtocol {
    func fetchTrendingMovies(page: Int) -> AnyPublisher<[MovieDTO]?, Error> {
        return Fail(error: NetworkFailure.failedToParseData)
            .eraseToAnyPublisher()
    }
    
    func fetchGenres() -> AnyPublisher<[GenreDTO]?, Error> {
        return Fail(error: NetworkFailure.generalFailure)
            .eraseToAnyPublisher()
    }
}
