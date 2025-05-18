//
//  MovieRowView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: movie.posterURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
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
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.headline)
                    if let overview = movie.overview {
                        Text(overview)
                            .font(.subheadline)
                            .lineLimit(3)
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
}


#Preview {
    MovieRowView(movie: .preview)
}
