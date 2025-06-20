//
//  MovieOverviewView.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import SwiftUI

struct MovieOverviewView: View {
    let overview: String?

    var body: some View {
        if let overview = overview {
            Text(overview)
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal)
        }
    }
}
