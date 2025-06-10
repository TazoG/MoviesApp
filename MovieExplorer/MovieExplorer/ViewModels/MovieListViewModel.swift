//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import Foundation
import Combine

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText = ""

    private let movieService: MovieServiceProtocol

    private var cancellables = Set<AnyCancellable>()

    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService

        $searchText
            .debounce(for: .milliseconds(2000), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard let self = self else { return }
                Task {
                    await self.fetchMovies(for: self.currentPage, query: searchText)
                }
            }
            .store(in: &cancellables)
    }

    var currentPage = 1
    var totalPages = 100

    func fetchMovies(for page: Int, query: String) async {
        isLoading = true
        errorMessage = nil
        currentPage = page

        do {
            let newMovies = try await movieService.fetchPopularMovies(page: page, query: query)
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

