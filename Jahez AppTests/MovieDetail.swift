//
//  MovieDetail.swift
//  Jahez AppTests
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
@testable import Jahez_App

extension MovieDetailDTO {
    static var mock: MovieDetailDTO {
        MovieDetailDTO(
            adult: false,
            backdropPath: "/mock_backdrop.jpg",
            belongsToCollection: BelongsToCollection(
                backdropPath: "/mock_collection_backdrop.jpg", id: 1,
                name: "Mock Collection",
                posterPath: "/mock_collection_poster.jpg"
            ),
            budget: 150000000,
            genres: [
                GenreDTO(id: 28, name: "Action"),
                GenreDTO(id: 12, name: "Adventure")
            ],
            homepage: "https://mockmovie.example.com",
            id: 12345,
            imdbID: "tt1234567",
            originCountry: ["US"],
            originalLanguage: "en",
            originalTitle: "Mock Original Title",
            overview: "This is a mock movie used for unit testing.",
            popularity: 8.7,
            posterPath: "/mock_poster.jpg",
            productionCompanies: [
                ProductionCompany(
                    id: 101,
                    logoPath: "/mock_logo.png",
                    name: "Mock Studios",
                    originCountry: "US"
                )
            ],
            productionCountries: [
                ProductionCountry(iso3166_1: "US", name: "United States of America")
            ],
            releaseDate: "2025-01-01",
            revenue: 500000000,
            runtime: 140,
            spokenLanguages: [
                SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")
            ],
            status: "Released",
            tagline: "The best mock you'll ever see.",
            title: "Mock Movie Title",
            video: false,
            voteAverage: 7.8,
            voteCount: 1200
        )
    }
}
