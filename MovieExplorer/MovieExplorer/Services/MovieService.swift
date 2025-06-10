//
//  MovieService.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import Foundation

final class MovieService: MovieServiceProtocol {
    private let apiKey: String
    private let baseURL: String
    private let urlSession: URLSession

    init(apiKey: String = Constants.apiKey,
         baseURL: String = Constants.baseURL,
         urlSession: URLSession = .shared) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    func fetchPopularMovies(page: Int, query: String) async throws -> [Movie] {
        let endpoint: APIEndpoint = query.isEmpty
            ? .popularMovies(page: page)
            : .searchMovies(page: page, query: query)
        return try await fetchMovies(from: endpoint)
    }

    func fetchMovieTrailer(movieId: Int) async throws -> URL? {
        guard let url = APIEndpoint.movieTrailer(movieId: movieId).url(apiKey: apiKey, baseURL: baseURL) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await urlSession.data(from: url)
        try validate(response: response)
        let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
        return videoResponse.results.first(where: { $0.type == "Trailer" && $0.site == "YouTube" })
            .flatMap { URL(string: "https://www.youtube.com/watch?v=\($0.key)") }
    }

    func fetchGenres() async throws -> [Genre] {
        guard let url = APIEndpoint.genres.url(apiKey: apiKey, baseURL: baseURL) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await urlSession.data(from: url)
        try validate(response: response)
        let genreResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
        return genreResponse.genres
    }

    func fetchMoviesByGenre(genreId: Int) async throws -> [Movie] {
        return try await fetchMovies(from: .moviesByGenre(genreId: genreId))
    }

    // MARK: - Helpers

    private func fetchMovies(from endpoint: APIEndpoint) async throws -> [Movie] {
        guard let url = endpoint.url(apiKey: apiKey, baseURL: baseURL) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await urlSession.data(from: url)
        try validate(response: response)
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse.results
    }

    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}
