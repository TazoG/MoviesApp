//
//  MovieListView.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    @State private var searchText = ""

    var body: some View {

        NavigationStack {
            if viewModel.isLoading {
                ZStack {
                    Color.clear
                    ProgressView("Loading movies...")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button {
                        Task {
                            await viewModel.fetchMovies()
                        }
                    } label: {
                        Label("Retry", systemImage: "arrow.clockwise")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
            } else if viewModel.filteredMovies(searchText: searchText).isEmpty {
                VStack {
                    Spacer()
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundColor(.gray)
                    Text("No movies found.")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                }
            } else {
                List(viewModel.filteredMovies(searchText: searchText)) { movie in
                    MovieRowView(movie: movie)
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Movies")
                            .font(.title2.bold())
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search Movie...")
        .task {
            await viewModel.fetchMovies()
        }
    }
}

#Preview {
    MovieListView()
}
