//
//  FavoritesView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query private var favorites: [FavoriteMovie]

    var body: some View {
        NavigationStack {
            List(favorites) { movie in
                Text(movie.title)
            }
            .navigationTitle("Favorites")
        }
    }
}


#Preview {
    FavoritesView()
}
