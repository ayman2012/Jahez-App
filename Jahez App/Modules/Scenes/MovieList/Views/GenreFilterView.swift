//
//  GenreFilterView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import SwiftUI

struct GenreFilterView: View {
    let genres: [GenreDTO]
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
