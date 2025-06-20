//
//  MovieInfoView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import SwiftUI

struct MovieInfoView: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text("\(title):")
                .font(.caption)
                .bold()
                .lineLimit(1)
                .foregroundColor(.white)
            
            Text(value)
                .font(.caption2)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
    }
}
