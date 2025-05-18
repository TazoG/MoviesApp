//
//  MovieDetailView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

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
    }
}


#Preview {
    MovieDetailView(movie: .preview)
}
