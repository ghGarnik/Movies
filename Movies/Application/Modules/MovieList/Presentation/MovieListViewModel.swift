//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieListViewModel {
    private let selectedMovieRelay: PublishRelay<Movie>
    private let repository: MovieRepository

    init(repository: MovieRepository, selectedMovieRelay: PublishRelay<Movie>) {
        self.repository = repository
        self.selectedMovieRelay = selectedMovieRelay
    }
}

extension MovieListViewModel: MovieListViewModelProtocol {

    var title: Driver<String> {
        .just("Awesome Movies!!")
    }

    var movies: Driver<[Movie]> {
        repository.movies()
            .asDriver(onErrorJustReturn: [])
    }

    var didSelectMovie: PublishRelay<Movie> {
        selectedMovieRelay
    }
}

