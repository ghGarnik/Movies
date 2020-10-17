//
//  Movie.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 16/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String?
    let posterUrl: URL?
    let year: String?
    let rate: Double
    let genre: String?
    let budget: Double?
    let overview: String?

    init(id: Int, title: String? = nil, posterUrl: URL?, year: String?, rate: Double, genre: String? = nil, budget: Double? = nil, overview: String? = nil) {
        self.id = id
        self.title = title
        self.posterUrl = posterUrl
        self.year = year
        self.rate = rate
        self.genre = genre
        self.budget = budget
        self.overview = overview
    }
}
