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
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBar(text: $viewModel.searchText)
                Text("Watch New Movies")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.yellow)
                    .padding(.horizontal)
                GenreFilterView(genres: viewModel.genres, selected: $viewModel.selectedGenreIDs)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(Array(viewModel.filteredMovies.enumerated()), id: \.element.id) { index, movie in            let movie = viewModel.filteredMovies[index]
                            VStack(alignment: .leading, spacing: 4) {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 180)
                                        .clipped()
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 180)
                                }
                                Text(movie.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text(String(movie.releaseDate.prefix(4)))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .background(Color.black)
                            .cornerRadius(8)
                            .onAppear {
                                if index == viewModel.filteredMovies.count - 1 {
                                    viewModel.fetchMovies()
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Shared UI Components
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("Search TMDB", text: $text)
            .padding(12)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}

struct GenreFilterView: View {
    let genres: [Genre]
    @Binding var selected: Set<Int>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(genres) { genre in
                    Text(genre.name)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(selected.contains(genre.id) ? Color.yellow : Color.gray.opacity(0.2))
                        .foregroundColor(selected.contains(genre.id) ? .black : .white)
                        .cornerRadius(20)
                        .onTapGesture {
                            if selected.contains(genre.id) {
                                selected.remove(genre.id)
                            } else {
                                selected.insert(genre.id)
                            }
                        }
                }
            }.padding(.horizontal)
        }.padding(.bottom, 8)
    }
}
#Preview {
    MovieListView(viewModel: MovieListViewModel(repository: MovieRepository()))
}
