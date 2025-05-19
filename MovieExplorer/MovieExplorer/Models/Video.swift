//
//  Video.swift
//  MovieExplorer
//
//  Created by Tazo Gigitashvili on 20.05.25.
//

import Foundation

struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
}

