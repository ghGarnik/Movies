//
//  MovieListSearchState.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 18/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

struct MovieListSearchState {
    let currentMovieList: [Movie]
    let searchText: String
    let currentPage: Int
    let maximumPages: Int


    // These functions makes possible to keep the object immutable.
    func resetingState() -> MovieListSearchState {
        return MovieListSearchState(currentMovieList: [],
                                    searchText: self.searchText,
                                    currentPage: 0,
                                    maximumPages: 1)
    }

    func withQuery(_ searchText: String) -> MovieListSearchState {
        return MovieListSearchState(currentMovieList: self.currentMovieList,
                                    searchText: searchText,
                                    currentPage: self.currentPage,
                                    maximumPages: self.maximumPages)
    }
    
    func appendingMovies(from state: MovieListSearchState) -> MovieListSearchState {
        let movies = state.currentMovieList + self.currentMovieList
        return MovieListSearchState(currentMovieList: movies,
                                    searchText: self.searchText,
                                    currentPage: self.currentPage,
                                    maximumPages: self.maximumPages)
    }

    static func empty() -> MovieListSearchState {
        return MovieListSearchState(currentMovieList: [],
                                    searchText: "",
                                    currentPage: 0,
                                    maximumPages: 1)
    }
}
