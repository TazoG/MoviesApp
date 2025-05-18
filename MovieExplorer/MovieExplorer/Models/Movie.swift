//
//  Movie.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double

    var posterURL: URL? {
            guard let path = posterPath else { return nil }
            return URL(string: "https://image.tmdb.org/t/p/w200\(path)")
        }

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

extension Movie {
    static let preview = Movie(
        id: 1,
        title: "The Dark Knight",
        overview: "Batman raises the stakes in his war on crime.",
        posterPath: "/preview.jpg",
        releaseDate: "2008-07-18", 
        voteAverage: 9.0
    )
}

