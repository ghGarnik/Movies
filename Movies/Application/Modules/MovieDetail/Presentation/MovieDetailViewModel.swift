//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 18/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieDetailViewModel {
    private let repository: MovieDetailRepository
    private let movieId: Int

    init(repository: MovieDetailRepository, movieId: Int) {
        self.repository = repository
        self.movieId = movieId
    }
}

extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    var movieDetail: Driver<MovieDetail> {
        repository.movies(id: movieId)
            .map { $0 as MovieDetail? }
            .asDriver(onErrorJustReturn: nil)
            .compactMap { $0 }
    }
}
