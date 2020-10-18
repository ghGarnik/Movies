//
//  MovieRepository.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import RxSwift

final class MovieRepository {

    private let service: MovieListService

    init(service: MovieListService) {
        self.service = service
    }

    func movies() -> Single<[Movie]> {
        service.movieList()
            .map { movieList -> [Movie] in
                return movieList.results
        }
    }
}
