//
//  MovieExplorerApp.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI
import SwiftData

@main
struct MovieExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView()
        }
        .modelContainer(for: FavoriteMovie.self)
    }
}
