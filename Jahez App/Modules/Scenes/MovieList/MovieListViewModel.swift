//
//  MovieListViewModel.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    @Published var movies: [MovieDTO] = []
    @Published var genres: [GenreDTO] = []
    @Published var error: Error?
    @Published var searchText = ""
    @Published var selectedGenreIDs: Set<Int> = []

    private let repository: MovieRepository
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private(set) var isLoading = false

    init(repository: MovieRepository) {
        self.repository = repository
        fetchGenres()
        fetchMovies()
    }

    func fetchGenres() {
        isLoading = true
        repository.fetchGenres()
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] genres in
                self?.genres = genres ?? []
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }

    func fetchMovies() {
        isLoading = true
        repository.fetchTrendingMovies(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] movies in
                self?.movies.append(contentsOf: movies ?? [])
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }

    var filteredMovies: [MovieDTO] {
        movies.filter { movie in
            (searchText.isEmpty || movie.title.lowercased().contains(searchText.lowercased())) &&
            (selectedGenreIDs.isEmpty || !Set(movie.genreIds).isDisjoint(with: selectedGenreIDs))
        }
    }
}
