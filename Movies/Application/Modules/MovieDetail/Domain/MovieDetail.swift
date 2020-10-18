//
//  MovieDetail.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 18/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let id: Int
    let title: String
    let posterUrl: URL?
    let overview: String
    let year: String
    let genres: String
    let rate: Double
    let budget: Double

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterUrl = "poster_path"
        case year = "release_date"
        case rate = "vote_average"
        case genres
        case budget
        case overview
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)

        let posterPath = try? values.decode(String.self, forKey: .posterUrl)
        if let posterPath = posterPath {
             posterUrl = Endpoints.image(posterPath).url
        } else {
            posterUrl = nil
        }

        overview = try values.decode(String.self, forKey: .overview)
        year = try values.decode(String.self, forKey: .year)

        genres = try values.decode([Genre].self, forKey: .genres).map { $0.name }.joined(separator: ", ")

        rate = try values.decode(Double.self, forKey: .rate)
        budget = try values.decode(Double.self, forKey: .budget)
    }
}
