//
//  MovieRepository.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import RxSwift

final class MovieRepository {
    //MARK: - init

    private let service: MovieListService

    init(service: MovieListService) {
        self.service = service
    }
}

//MARK: - MovieRepositoryProtocol

extension MovieRepository: MovieRepositoryProtocol {

    /// Returns a new MovieListSearchState for query in state.
    /// - Parameter state: state containing query to make.
    /// - Returns: new state including fetched list of Movie.
    func movies(forState state: MovieListSearchState) -> Single<MovieListSearchState> {
        guard state.currentPage <= state.maximumPages else {
            return Single.create { emitter -> Disposable in
                emitter(.success(state))
                return Disposables.create()
            }
        }

        return service.movieList(query: state.searchText, page: state.currentPage+1)
            .map { movieList -> MovieListSearchState in
                return MovieListSearchState(currentMovieList: movieList.results,
                                            searchText: state.searchText,
                                            currentPage: movieList.page, maximumPages: movieList.totalPages)
        }
    }
}
