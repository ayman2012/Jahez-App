//
//  MovieListResponseDTO.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation

struct MovieListResponseDTO: Codable {
    let page: Int
    let results: [MovieDTO]
}

struct MovieDTO: Identifiable, Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let adult: Bool
    let video: Bool
    let genreIds: [Int]
    var posterFullPath: String {
        "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview, adult, video, popularity, voteCount = "vote_count", voteAverage = "vote_average"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
    }
}
