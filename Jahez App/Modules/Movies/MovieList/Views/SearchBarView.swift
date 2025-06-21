//
//  SearchBarView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import SwiftUI

// MARK: - Shared UI Components
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text, prompt: placeholderView)
            .padding(12)
            .foregroundColor(.white)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
extension SearchBar {
    var placeholderView: Text {
        Text("Search TMDB")
            .foregroundColor(.white)
            .font(.body)
    }
}
