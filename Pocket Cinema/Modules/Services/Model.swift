//
//  Model.swift
//  Pocket Cinema
//
//  Created by Айдар on 12.05.2025.
//

import UIKit

struct MovieResponse: Decodable {
    let search: [Movie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Movie: Decodable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Decodable {
    case movie = "movie"
}
