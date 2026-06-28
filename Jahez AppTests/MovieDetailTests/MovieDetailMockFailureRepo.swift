//
//  MovieDetailMockFailureRepo.swift
//  Jahez AppTests
//
//  Created by Ayman Fathy on 22/06/2025.
//

import Combine
@testable import Jahez_App

final class MovieDetailMockFailureRepo: MovieDetailsRepositoryProtocol {
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetailDTO?, Error> {
        return Fail(error: NetworkFailure.failedToParseData)
            .eraseToAnyPublisher()
    }
}
