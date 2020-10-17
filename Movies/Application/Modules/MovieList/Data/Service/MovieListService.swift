//
//  MovieListService.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation
import RxSwift
import Keys

struct MovieListService {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func movieList() -> Single<MovieListCodable> {
        .create { observer -> Disposable in
            let apiKey = MoviesKeys().apiKey
            let request: Single<MovieListCodable> = self.apiClient.request(url: Endpoints.topRated.url,
                              method: .get, parameters: ["api_key": apiKey], headers: [])

            let _ = request.subscribe(onSuccess: { movieListCodable in
                observer(.success(movieListCodable))
            }) { error in
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}
