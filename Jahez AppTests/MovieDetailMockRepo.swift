//
//  MovieDetailMockRepo.swift
//  Jahez AppTests
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import Combine
@testable import Jahez_App

final class MovieDetailMockRepo: MovieDetailsRepositoryProtocol {
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetailDTO?, Error> {
        return Just(MovieDetailDTO.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
