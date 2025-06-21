//
//  MovieListViewModel.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Combine

final class MovieListViewModel: ObservableObject {

    enum Action {
        case fetch
        case loadMore(index: Int)
    }

    private var movies: [MovieDTO] = []
    @Published var genres: [GenreDTO] = []
    @Published var error: Error?
    @Published var searchText = ""
    @Published var selectedGenreIDs: Set<Int> = []

    private let repository: MovieRepositoryProtocol
    private var cancellable = Set<AnyCancellable>()
    private var currentPage = 1
    private(set) var isLoading = false

    var filteredMovies: [MovieDTO] {
        movies.filter { movie in
            (searchText.isEmpty || movie.title.lowercased().contains(searchText.lowercased())) &&
            (selectedGenreIDs.isEmpty || !Set(movie.genreIds).isDisjoint(with: selectedGenreIDs))
        }
    }

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func trigger(_ action: Action) {
        switch action {
        case .fetch:
            fetchGenres()
            fetchMovies()
        case let .loadMore(index):
            guard index == filteredMovies.count - 1 else {
                return
            }
            fetchMovies()
        }
    }

    private func fetchGenres() {
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
            .store(in: &cancellable)
    }

    private func fetchMovies() {
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
            .store(in: &cancellable)
    }
}
