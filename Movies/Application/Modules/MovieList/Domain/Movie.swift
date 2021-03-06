//
//  Movie.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 16/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let posterUrl: URL?
    let year: String
    let rate: Double

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterUrl = "poster_path"
        case year = "release_date"
        case rate = "vote_average"
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

        year = try values.decode(String.self, forKey: .year)
        rate = try values.decode(Double.self, forKey: .rate)
    }
}
