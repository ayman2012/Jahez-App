//
//  Jahez_AppApp.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import SwiftUI

@main
struct Jahez_AppApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieListViewModel(repository: MovieRepository()))
        }
    }
}
