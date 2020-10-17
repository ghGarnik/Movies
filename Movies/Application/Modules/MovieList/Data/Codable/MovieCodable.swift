//
//  MovieCodable.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

struct MovieCodable: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let voteAverage: Double

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
    }

    func toDomain() -> Movie {
        return Movie(id: id,
                     title: title,
                     posterUrl: Endpoints.image(posterPath ?? "").url,
                     year: releaseDate,
                     rate: voteAverage,
                     genre: "default genre",
                     budget: nil, overview: overview)
    }
}
