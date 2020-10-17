//
//  Movie.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 16/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

struct Movie {
    let title: String?
    let year: Int
    let rate: Int
    let genre: String?
    let budget: Double?
    let overview: String?

    init(title: String? = nil, year: Int, rate: Int, genre: String? = nil, budget: Double? = nil, overview: String? = nil) {
        self.title = title
        self.year = year
        self.rate = rate
        self.genre = genre
        self.budget = budget
        self.overview = overview
    }
}
