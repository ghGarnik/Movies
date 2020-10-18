//
//  Endpoint.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

enum Endpoints {
    case topRated
    case search
    case movie(Int)
    case genres
    case image(String)

    private var baseURL: String {
        switch self {
        case .image:
            return "https://image.tmdb.org/t/p/w500"
        default:
            return "https://api.themoviedb.org/3"
        }
    }
    
    private var path: String {
        switch self {
        case .topRated:
            return "/movie/top_rated"
        case .search:
            return "/search/movie"
        case .movie(let id):
            return "/movie/\(String(id))"
        case .genres:
            return "/genre/movie/list"
        case .image(let imagePath):
            return imagePath
        }
    }
    //MARK: - Full path Generation

    var url: URL {
        return URL(string: self.baseURL.appending(self.path))!
    }
}
