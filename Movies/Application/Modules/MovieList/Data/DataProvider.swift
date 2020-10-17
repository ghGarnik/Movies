//
//  DataProvider.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import RxSwift

final class DataProvider {

    private let service: MovieListService

    init(service: MovieListService) {
        self.service = service
    }

    func movies() -> Single<[Movie]> {
        service.movieList()
            .map { movieListCodable -> [Movie] in
                return movieListCodable.results.map { $0.toDomain() }
        }
    }
}
