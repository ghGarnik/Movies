//
//  MovieDetailRepository.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 18/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation
import RxSwift

final class MovieDetailRepository {

    private let service: MovieDetailService

    init(service: MovieDetailService) {
        self.service = service
    }

    func movies(id: Int) -> Single<MovieDetail> {
        service.movieList(id: id)
            .map { movieDetail -> MovieDetail in
                return movieDetail
        }
    }
}
