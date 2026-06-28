//
//  MovieListViewModeTests.swift
//  Jahez AppTests
//
//  Created by Ayman Fathy on 22/06/2025.
//

import Combine
import XCTest
@testable import Jahez_App

final class MovieListViewModeTests: XCTestCase {
    var movieListViewModel: MovieListViewModel!
    var movieListMockSuccessRepo: MovieListRepositoryProtocol!
    var movieListMockFailureRepo: MovieListRepositoryProtocol!

    override func setUpWithError() throws {
        movieListMockSuccessRepo = MovieListMockRepo()
        movieListMockFailureRepo = MovieListMockRepoWithFailure()
        movieListViewModel = MovieListViewModel(repository: movieListMockSuccessRepo)
    }

    override func tearDownWithError() throws {
        movieListViewModel = nil
        movieListMockSuccessRepo = nil
        movieListMockFailureRepo = nil
    }

    func testFetchMovieListWithSuccess() {
        movieListViewModel.trigger(.fetch)
        XCTAssertEqual(movieListViewModel.filteredMovies.count , 1)
    }
    
    func testFetchGenresWithSuccess() {
        movieListViewModel.trigger(.fetch)
        XCTAssertEqual(movieListViewModel.genres.count , 11)
    }
    
    func testFetchMovieListWithErrorNotNilFailure() {
        movieListViewModel = MovieListViewModel(repository: movieListMockFailureRepo)
        movieListViewModel.trigger(.fetch)
        XCTAssertNotNil(movieListViewModel.error)
    } 
    
    func testFetchMovieListWithErrorDescriptionFailure() {
        movieListViewModel = MovieListViewModel(repository: movieListMockFailureRepo)
        movieListViewModel.trigger(.fetch)
        XCTAssertEqual(movieListViewModel.error?.localizedDescription ?? "" , "Technical Difficulties, we can't fetch the data")
    }
}
