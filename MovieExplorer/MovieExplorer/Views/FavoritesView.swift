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
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            if favorites.isEmpty {
                ContentUnavailableView("No Favorites", systemImage: "heart", description: Text("Mark movies as favorites to see them here."))
            } else {
                List {
                    ForEach(favorites, id: \.id) { favorite in
                        NavigationLink(destination: MovieDetailView(movie: favorite.toMovie())) {
                            HStack(alignment: .top) {
                                AsyncImage(url: favorite.posterURL) { phase in
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
                                    Text(favorite.title)
                                        .font(.headline)
                                    
                                    if let overview = favorite.overview {
                                        Text(overview)
                                            .font(.subheadline)
                                            .lineLimit(3)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
                .navigationTitle("Favorites")
            }
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(favorites[index])
        }
    }
}




#Preview {
    FavoritesView()
}
