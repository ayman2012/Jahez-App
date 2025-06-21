//
//  MovieHeaderImage.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import SwiftUI

struct MovieHeaderImageView: View {
    let posterPath: String?

    var body: some View {
        if let posterPath = posterPath {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                image
                    .resizable()
                    .frame(height: 300)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 300)
            }
        }
    }
}
