//
//  MovieRowView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI
import SwiftData

struct MovieRowView: View {
    let movie: Movie

    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteMovie]

    var isFavorite: Bool {
        favorites.contains { $0.id == movie.id }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 120, height: 80)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 120)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "film")
                        .resizable()
                        .frame(width: 80, height: 120)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(movie.title)
                        .font(.headline)

                    Spacer()

                    Button(action: toggleFavorite) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                    }
                    .buttonStyle(.plain)
                }

                if let overview = movie.overview {
                    Text(overview)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .background(
            NavigationLink("", destination: MovieDetailView(movie: movie))
                .opacity(0)
        )
    }

    private func toggleFavorite() {
        if let existing = favorites.first(where: { $0.id == movie.id }) {
            modelContext.delete(existing)
        } else {
            let favorite = movie.toFavorite()
            modelContext.insert(favorite)
        }
    }
}


#Preview {
    MovieRowView(movie: .preview)
}
