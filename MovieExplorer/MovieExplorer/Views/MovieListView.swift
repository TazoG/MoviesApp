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
    @State private var currentPage = 1

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
                            await viewModel.fetchMovies(for: currentPage, query: searchText)
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
            } else if viewModel.movies.isEmpty {
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
                List(viewModel.movies) { movie in
                    MovieRowView(movie: movie)
                }
                .listStyle(.plain)
                .navigationTitle("Movies")
            }

            HStack(spacing: 24) {
                Button {
                    if currentPage > 1 {
                        currentPage -= 1
                        Task {
                            await viewModel.fetchMovies(for: currentPage, query: searchText)
                        }
                    }
                } label: {
                    Label("Previous", systemImage: "chevron.left")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(currentPage == 1 ? .gray : .blue)
                        .cornerRadius(12)
                }
                .disabled(currentPage == 1)

                Text("Page \(currentPage)")
                    .font(.headline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                Button {
                    currentPage += 1
                    Task {
                        await viewModel.fetchMovies(for: currentPage, query: searchText)
                    }
                } label: {
                    Label("Next", systemImage: "chevron.right")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                }
                .disabled(viewModel.movies.isEmpty)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(radius: 2)
        }
        .searchable(text: $searchText, prompt: "Search Movie...")
        .onChange(of: searchText) {
            currentPage = 1
            Task {
                await viewModel.fetchMovies(for: currentPage, query: searchText)
            }
        }
        .task {
            await viewModel.fetchMovies(for: currentPage, query: searchText)
        }
    }
}

#Preview {
    MovieListView()
}
