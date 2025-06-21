//
//  MovieSummaryView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import SwiftUI

struct MovieSummaryView: View {
    let movie: MovieDetailDTO?

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let posterPath = movie?.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 120)
                        .cornerRadius(8)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 120)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                let titleWithYear = "\(movie?.title ?? "") (\(String(movie?.releaseDate.prefix(4) ?? "")))"
                Text(titleWithYear)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(movie?.genres.map { $0.name }.joined(separator: ", ") ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
}
