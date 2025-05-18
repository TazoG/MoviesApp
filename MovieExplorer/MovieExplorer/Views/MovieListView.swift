//
//  MovieListView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Loading movies...")
                    Spacer()
                }
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        Task {
                            await viewModel.fetchMovies()
                        }
                    }
                    .padding(.top)
                }
                .padding()
            } else {
                List(viewModel.movies) { movie in
                    HStack(alignment: .top) {
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
                .listStyle(.plain)
                .navigationTitle("Popular Movies")
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}



#Preview {
    MovieListView()
}
