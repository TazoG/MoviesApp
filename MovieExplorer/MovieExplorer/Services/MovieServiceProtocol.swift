//
//  MovieServiceProtocol.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 11.06.25.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchPopularMovies(page: Int, query: String) async throws -> [Movie]
    func fetchMovieTrailer(movieId: Int) async throws -> URL?
    func fetchGenres() async throws -> [Genre]
    func fetchMoviesByGenre(genreId: Int) async throws -> [Movie]
}
