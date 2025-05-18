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
                    MovieRowView(movie: movie)
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
