//
//  GenreDTOMock.swift
//  Jahez AppTests
//
//  Created by Ayman Fathy on 22/06/2025.
//

import Foundation
@testable import Jahez_App

extension GenreDTO {
    static var mock: [GenreDTO] {
         [
            GenreDTO(id: 28, name: "Action"),
            GenreDTO(id: 12, name: "Adventure"),
            GenreDTO(id: 16, name: "Animation"),
            GenreDTO(id: 35, name: "Comedy"),
            GenreDTO(id: 80, name: "Crime"),
            GenreDTO(id: 18, name: "Drama"),
            GenreDTO(id: 14, name: "Fantasy"),
            GenreDTO(id: 27, name: "Horror"),
            GenreDTO(id: 10749, name: "Romance"),
            GenreDTO(id: 878, name: "Science Fiction"),
            GenreDTO(id: 53, name: "Thriller")
        ]
    }
}
