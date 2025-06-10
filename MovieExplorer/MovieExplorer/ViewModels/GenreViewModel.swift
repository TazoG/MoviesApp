//
//  GenreViewModel.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 10.06.25.
//

import Foundation

@MainActor
class GenreViewModel: ObservableObject {
    @Published var genres: [Genre] = []
    @Published var selectedGenreMovies: [Movie] = []
    @Published var selectedGenre: Genre?

    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }

    func fetchGenres() async {
        do {
            genres = try await movieService.fetchGenres()
        } catch {
            print("Error fetching genres: \(error)")
        }
    }

    func fetchMovies(for genre: Genre) async {
        do {
            selectedGenre = genre
            selectedGenreMovies = try await movieService.fetchMoviesByGenre(genreId: genre.id)
        } catch {
            print("Error fetching movies for genre: \(error)")
        }
    }
}
