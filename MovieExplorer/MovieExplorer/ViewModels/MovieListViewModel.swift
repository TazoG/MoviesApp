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

    var currentPage = 1
    var totalPages = 100

    func fetchMovies(for page: Int) async {
        isLoading = true
        errorMessage = nil
        currentPage = page

        do {
            let newMovies = try await movieService.fetchPopularMovies(page: page)
            movies = newMovies
        } catch {
            errorMessage = "Failed to load movies: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func filteredMovies(searchText: String) -> [Movie] {
        guard !searchText.isEmpty else { return movies }
        return movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(searchText)
        }
    }
}

