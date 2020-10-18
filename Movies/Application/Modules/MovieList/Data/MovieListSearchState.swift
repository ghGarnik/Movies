//
//  MovieListSearchState.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 18/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

struct MovieListSearchState {
    var currentMovieList = [Movie]()
    var searchText: String
    var currentPage: Int = 0
    var maximumPages: Int = 1
    
    init(searchText: String) {
        self.searchText = searchText
    }
    
    func resetingState() -> MovieListSearchState {
        var state = self
        state.currentMovieList = []
        state.currentPage = 0
        state.maximumPages = 1
        return state
    }
    
    func appendingMovies(from state: MovieListSearchState) -> MovieListSearchState {
        var newState = self
        newState.currentMovieList = state.currentMovieList + self.currentMovieList
        return newState
    }
}
