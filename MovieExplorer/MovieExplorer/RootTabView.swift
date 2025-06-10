//
//  ContentView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }

            GenreView()
                .tabItem {
                    Label("Genres", systemImage: "square.stack.3d.forward.dottedline.fill")
                }
        }
    }
}


#Preview {
    RootTabView()
}
