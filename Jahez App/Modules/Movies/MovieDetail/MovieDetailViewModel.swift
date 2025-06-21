//
//  MovieDetailViewModel.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Combine

final class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetailDTO?
    @Published var isLoading = false
    @Published var error: Error?
    private let selectedMovieId: Int

    private let repository: MovieDetailsRepositoryProtocol
    private var cancellable = Set<AnyCancellable>()
    enum Action {
        case fetchDetails
    }
    init(
        repository: MovieDetailsRepositoryProtocol,
        movieId: Int
    ) {
        self.repository = repository
        self.selectedMovieId = movieId

    }

    func trigger(_ action: Action) {
        switch action {
        case .fetchDetails:
            fetchMovieDetails(id: selectedMovieId)
        }
    }

   private func fetchMovieDetails(id: Int) {
        isLoading = true
        repository.fetchMovieDetails(id: id)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false

                if case let .failure(error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] detail in
                self?.movieDetail = detail
            })
            .store(in: &cancellable)
    }
}
