//
//  MovieDetailView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI
import SwiftData

struct MovieDetailView: View {
    let movie: Movie

    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteMovie]

    var isFavorite: Bool {
        favorites.contains { $0.id == movie.id }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: movie.posterURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    case .failure:
                        Image(systemName: "film")
                            .resizable()
                            .frame(width: 120, height: 180)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }

                Text(movie.title)
                    .font(.title)
                    .bold()

                Text("Release date: \(movie.releaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(movie.overview ?? "No Description")
                    .font(.body)
                    .padding(.top)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)

        Button {
            toggleFavorite()
        } label: {
            Label(isFavorite ? "Remove Favorite" : "Add to Favorites", systemImage: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .red : .primary)
        }
    }

    func toggleFavorite() {
        if let favorite = favorites.first(where: { $0.id == movie.id }) {
            modelContext.delete(favorite)
        } else {
            let newFavorite = FavoriteMovie(
                id: movie.id,
                title: movie.title,
                posterPath: movie.posterPath,
                overview: movie.overview,
                releaseDate: movie.releaseDate
            )
            modelContext.insert(newFavorite)
        }
    }
}



#Preview {
    MovieDetailView(movie: .preview)
}
