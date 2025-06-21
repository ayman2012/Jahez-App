//
//  MovieDTOMock.swift
//  Jahez AppTests
//
//  Created by Ayman Fathy on 22/06/2025.
//

import Foundation
@testable import Jahez_App

extension MovieDTO {
    static var mock: MovieDTO {
        MovieDTO(
            id: 12345,
            title: "Mock Movie Title",
            originalTitle: "Original Mock Title",
            originalLanguage: "en",
            overview: "This is a mock overview of the movie. It provides a brief summary of the plot and main theme.",
            releaseDate: "2025-06-21",
            posterPath: "/mockPosterPath.jpg",
            backdropPath: "/mockBackdropPath.jpg",
            voteAverage: 8.5,
            voteCount: 1200,
            popularity: 987.65,
            adult: false,
            video: false,
            genreIds: [28, 12, 878] // Action, Adventure, Sci-Fi
        )
    }
}
