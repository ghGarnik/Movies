//
//  MovieListCodable.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

struct MovieListCodable: Codable {
    let page: Int
    let results: [MovieCodable]
    let totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
