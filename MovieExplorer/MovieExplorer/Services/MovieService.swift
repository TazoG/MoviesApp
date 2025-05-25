//
//  MovieService.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import Foundation

class MovieService {
    private let apiKey = "1a96a69f1ad40a2dde00e71900241f7d"

    func fetchPopularMovies(page: Int, query: String) async throws -> [Movie] {

        let urlString = query.count == 0 ? "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&page=\(page)" :  "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&page=\(page)&query=\(query)"


        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
        return decoded.results
    }

    func fetchMovieTrailer(movieId: Int) async throws -> URL? {
        let url = URL(string: "\(Constants.baseURL)/movie/\(movieId)/videos?api_key=\(Constants.apiKey)&language=en-US")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(VideoResponse.self, from: data)

        if let trailer = response.results.first(where: { $0.type == "Trailer" && $0.site == "YouTube" }) {
            return URL(string: "https://www.youtube.com/watch?v=\(trailer.key)")
        } else {
            return nil
        }
    }
}

struct Constants {
    static let apiKey = "1a96a69f1ad40a2dde00e71900241f7d"
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
}



