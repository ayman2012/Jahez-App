//
//  MovieHomepageView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import SwiftUI

struct MovieHomepageView: View {
    let homepage: String?

    var body: some View {
        if let homepage = homepage, let url = URL(string: homepage) {
            HStack(alignment: .top) {
                Text("Homepage:")
                    .font(.caption)
                    .foregroundColor(.white)
                    .bold()
                Link(homepage, destination: url)
                    .font(.caption2)
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
        }
    }
}
