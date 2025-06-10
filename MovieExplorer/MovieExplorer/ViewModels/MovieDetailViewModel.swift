//
//  MovieDetailViewModel.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 20.05.25.
//

import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var trailerURL: URL?
    @Published var isLoadingTrailer = false

    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }

    func loadTrailer(for movieId: Int) async {
        isLoadingTrailer = true
        trailerURL = try? await movieService.fetchMovieTrailer(movieId: movieId)
        isLoadingTrailer = false
    }
}
