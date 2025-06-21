//
//  MovieListView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel: MovieListViewModel

    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if let error = viewModel.error {
                VStack {
                    Spacer()
                    Text(error.localizedDescription)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                    Spacer()
                }
            } else {
                NavigationView {
                    VStack(alignment: .leading, spacing: 0) {
                        SearchBar(text: $viewModel.searchText)

                        Text("Watch New Movies")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.yellow)
                            .padding()

                        GenreFilterView(
                            genres: viewModel.genres,
                            selected: $viewModel.selectedGenreIDs
                        )

                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(Array(viewModel.filteredMovies.enumerated()), id: \.element.id) { index, movie in
                                    NavigationLink(
                                        destination: MovieDetailView(
                                            viewModel: MovieDetailViewModel(
                                                repository: MovieDetailsRepository(),
                                                movieId: movie.id
                                            )
                                        )
                                    ) {
                                        MovieCardView(movie: movie)
                                    }
                                    .onAppear {
                                        viewModel.trigger(.loadMore(index: index))

                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .background(Color.black)
                    .navigationBarHidden(true)
                }
            }

            if viewModel.isLoading {
                LoadingView()
            }
            if viewModel.filteredMovies.isEmpty {
                contentUnavailable
            }
        }
        .onAppear {
            viewModel.trigger(.fetch)
        }
    }
}

extension MovieListView {
    var contentUnavailable: some View {
        ContentUnavailableView {
            Label(
                "No Movies for \"\(viewModel.searchText)\"",
                systemImage: "magnifyingglass"
            )
        } description: {
            Text("Try to search for another Hero.")
        }
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel(repository: MovieRepository()))
}
