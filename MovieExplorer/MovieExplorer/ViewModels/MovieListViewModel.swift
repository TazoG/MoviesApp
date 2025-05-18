//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let movieService = MovieService()

    func fetchMovies() async {
        isLoading = true
        errorMessage = nil

        do {
            let movieList = try await movieService.fetchPopularMovies()
            movies = movieList
        } catch {
            errorMessage = "Failed to load movies: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
