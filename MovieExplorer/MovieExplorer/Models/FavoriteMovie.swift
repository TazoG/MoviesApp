//
//  FavoriteMovie.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 18.05.25.
//

import Foundation
import SwiftData

@Model
class FavoriteMovie {
    @Attribute(.unique) var id: Int
    var title: String
    var posterPath: String?
    var overview: String?
    var releaseDate: String

    init(id: Int, title: String, posterPath: String?, overview: String?, releaseDate: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
    }
}

extension FavoriteMovie {
    func toMovie() -> Movie {
        Movie(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            releaseDate: releaseDate, 
            voteAverage: 0.0
        )
    }

    var posterURL: URL? {
        Movie.imageBaseURL.appending(path: posterPath ?? "")
    }
}
