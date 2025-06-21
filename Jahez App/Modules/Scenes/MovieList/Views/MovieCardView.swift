//
//  MovieCardView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import SwiftUI
struct MovieCardView: View {
    let movie: MovieDTO

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            AsyncImage(url: URL(string: movie.posterFullPath)) { image in
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
            .cornerRadius(8)

            Text(movie.title)
                .font(.headline)
                .foregroundStyle(.white)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .padding([.vertical, .leading], 10)

            Text(String(movie.releaseDate.prefix(4)))
                .font(.caption)
                .foregroundColor(.gray)
                .padding([.bottom, .leading], 10)

        }
        .background(Color.gray.opacity(0.3))
        .cornerRadius(8)
    }
}
