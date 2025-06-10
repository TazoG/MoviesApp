//
//  GenreView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 10.06.25.
//

import SwiftUI

struct GenreView: View {
    @StateObject private var viewModel = GenreViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.genres) { genre in
                            Button(action: {
                                Task { await viewModel.fetchMovies(for: genre) }
                            }) {
                                Text(genre.name)
                                    .padding(8)
                                    .background(viewModel.selectedGenre?.id == genre.id ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                if viewModel.selectedGenreMovies.isEmpty {
                    ContentUnavailableView("Select a Genre", systemImage: "film")
                        .padding(.top, 100)
                } else {
                    List(viewModel.selectedGenreMovies) { movie in
                        MovieRowView(movie: movie)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Browse by Genre")
        }
        .task {
            await viewModel.fetchGenres()
        }
    }
}


#Preview {
    GenreView()
}
