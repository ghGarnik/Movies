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
    //MARK: - Init
    
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

//MARK: - MovieListServiceProtocol

extension MovieListService: MovieListServiceProtocol {

    /// Returns MovieList for parameters.
    /// - Parameters:
    ///   - query: Film name query.
    ///   - page: Page to retrieve
    /// - Returns: MovieList  Single.
    func movieList(query: String, page: Int) -> Single<MovieList> {
        .create { observer -> Disposable in
            let apiKey = MoviesKeys().apiKey
            let url: URL
            var parameters = ["api_key": apiKey,
                              "page": String(page)]

            if query.isEmpty {
                url = Endpoints.topRated.url
            } else {
                url = Endpoints.search.url
                parameters["query"] = query
            }


            let request: Single<MovieList> = self.apiClient.request(url: url,
                                                                    method: .get,
                                                                    parameters: parameters,
                                                                    headers: [])

            let _ = request.subscribe(onSuccess: { movieListCodable in
                observer(.success(movieListCodable))
            }) { error in
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}
