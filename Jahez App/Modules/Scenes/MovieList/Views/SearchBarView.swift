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
        TextField("Search TMDB", text: $text)
            .padding(12)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
