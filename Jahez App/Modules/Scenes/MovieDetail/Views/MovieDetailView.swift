//
//  MovieDetailView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import SwiftUI

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    @State private var isShowingShareSheet = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.movieDetail == nil {
                Text("No Date :(")
                    .background(Color.white)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        MovieHeaderImageView(posterPath: viewModel.movieDetail?.posterPath)
                        MovieSummaryView(movie: viewModel.movieDetail)
                        MovieOverviewView(overview: viewModel.movieDetail?.overview)
                        
                        Spacer(minLength: 60)
                        
                        MovieHomepageView(homepage: viewModel.movieDetail?.homepage)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            if let movie = viewModel.movieDetail {
                                MovieInfoView(title: "Languages", value: movie.spokenLanguages.map { $0.name }.joined(separator: ", "))
                                HStack {
                                    MovieInfoView(title: "Status", value: movie.status)
                                    MovieInfoView(title: "Runtime", value: "\(movie.runtime) minutes")
                                }
                                HStack {
                                    MovieInfoView(title: "Budget", value: "\(movie.budget) $")
                                    MovieInfoView(title: "Revenue", value: "\(movie.revenue) $")
                                }
                            }
                        }
                    }
                }
               
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isShowingShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                }
            }
        }
        .sheet(isPresented: $isShowingShareSheet) {
            if let movie = viewModel.movieDetail {
                let titleWithYear = "\(movie.title) (\(String(movie.releaseDate.prefix(4))))"
                ShareSheet(items: [titleWithYear])
            }
        }
    }
}

#Preview {
    MovieDetailView(viewModel: MovieDetailViewModel(repository: MovieDetailsRepository(), movieId: 1))
}
