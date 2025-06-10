//
//  Genre.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 10.06.25.
//

import Foundation

struct Genre: Identifiable, Decodable {
    let id: Int
    let name: String
}

struct GenreResponse: Decodable {
    let genres: [Genre]
}
