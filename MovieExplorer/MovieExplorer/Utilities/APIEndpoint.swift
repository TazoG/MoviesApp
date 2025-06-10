//
//  APIEndpoint.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 11.06.25.
//

import Foundation

enum APIEndpoint {
    case popularMovies(page: Int)
    case searchMovies(page: Int, query: String)
    case movieTrailer(movieId: Int)
    case genres
    case moviesByGenre(genreId: Int)

    func url(apiKey: String, baseURL: String) -> URL? {
        switch self {
        case .popularMovies(let page):
            return URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)&language=en-US&page=\(page)")
        case .searchMovies(let page, let query):
            return URL(string: "\(baseURL)/search/movie?api_key=\(apiKey)&language=en-US&page=\(page)&query=\(query)")
        case .movieTrailer(let movieId):
            return URL(string: "\(baseURL)/movie/\(movieId)/videos?api_key=\(apiKey)&language=en-US")
        case .genres:
            return URL(string: "\(baseURL)/genre/movie/list?api_key=\(apiKey)&language=en-US")
        case .moviesByGenre(let genreId):
            return URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)&with_genres=\(genreId)")
        }
    }
}
