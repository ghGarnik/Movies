//
//  MovieRepositoryProtocol.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 18/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func movies(forState state: MovieListSearchState) -> Single<MovieListSearchState>
}
