//
//  MovieDetailService.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 18/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import Keys

struct MovieDetailService {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func movieList(id: Int) -> Single<MovieDetail> {
        .create { observer -> Disposable in
            let apiKey = MoviesKeys().apiKey
            let request: Single<MovieDetail> = self.apiClient.request(url: Endpoints.movie(id).url,
                                                                             method: .get,
                                                                             parameters: ["api_key": apiKey],
                                                                             headers: [])

            let _ = request.subscribe(onSuccess: { movieDetailCodable in
                observer(.success(movieDetailCodable))
            }) { error in
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}
