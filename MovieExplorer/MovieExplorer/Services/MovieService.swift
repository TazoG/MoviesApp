//
//  MovieService.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import Foundation

class MovieService {
    private let apiKey = "1a96a69f1ad40a2dde00e71900241f7d"

    func fetchPopularMovies() async throws -> [Movie] {
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&sort_by=popularity.desc"
        
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
}

