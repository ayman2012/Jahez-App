//
//  MovieDetailViewModeTests.swift
//  Jahez AppTests
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import Combine
import XCTest
@testable import Jahez_App

final class MovieDetailViewModeTests: XCTestCase {
    var movieDetailViewModel: MovieDetailViewModel!
    var movieDetailMockRepo: MovieDetailMockRepo!

    override func setUpWithError() throws {
        movieDetailMockRepo = MovieDetailMockRepo()
        movieDetailViewModel = MovieDetailViewModel(repository: movieDetailMockRepo, movieId: 1)
    }
    
    override func tearDownWithError() throws {
        movieDetailViewModel = nil
        movieDetailMockRepo = nil
    }
    
    func testFetchMovieDetails() {
        movieDetailViewModel.fetchMovieDetails(id: 1)
        XCTAssertEqual(movieDetailViewModel.movieDetail?.title ?? "", "Mock Movie Title")
    }
}
