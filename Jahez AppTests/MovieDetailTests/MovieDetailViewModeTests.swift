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
    var movieDetailMockFailureRepo: MovieDetailMockRepo!

    override func setUpWithError() throws {
        movieDetailMockRepo = MovieDetailMockRepo()
        movieDetailMockFailureRepo = MovieDetailMockRepo()
        movieDetailViewModel = MovieDetailViewModel(repository: movieDetailMockRepo, movieId: 1)
    }

    override func tearDownWithError() throws {
        movieDetailViewModel = nil
        movieDetailMockRepo = nil
    }

    func testFetchMovieDetailsWithSuccess() {
        movieDetailViewModel.trigger(.fetchDetails)
        XCTAssertEqual(movieDetailViewModel.movieDetail?.title ?? "", "Mock Movie Title")
    }
    
    func testFetchMovieDetailsWithFailure() {
        movieDetailViewModel = MovieDetailViewModel(repository: MovieDetailMockFailureRepo(), movieId: 1)
        movieDetailViewModel.trigger(.fetchDetails)
        XCTAssertNotNil(movieDetailViewModel.error)
    }
}
