//
//  MovieListViewModel.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Combine

final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var genres: [Genre] = []
    @Published var searchText = ""
    @Published var selectedGenreIDs: Set<Int> = []

    private let repository: MovieRepository
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var isLoading = false

    init(repository: MovieRepository) {
        self.repository = repository
        fetchGenres()
        fetchMovies()
    }

    func fetchGenres() {
        repository.fetchGenres()
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] genres in
                self?.genres = genres
            })
            .store(in: &cancellables)
    }

    func fetchMovies() {
        guard !isLoading else { return }
        isLoading = true

        repository.fetchTrendingMovies(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
            }, receiveValue: { [weak self] movies in
                self?.movies.append(contentsOf: movies)
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }

    var filteredMovies: [Movie] {
        movies.filter { movie in
            (searchText.isEmpty || movie.title.lowercased().contains(searchText.lowercased())) &&
            (selectedGenreIDs.isEmpty || !Set(movie.genreIds).isDisjoint(with: selectedGenreIDs))
        }
    }
}
