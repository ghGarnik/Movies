//
//  MovieListViewModelProtocol.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 17/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import RxCocoa

protocol MovieListViewModelProtocol {
    var title: Driver<String> { get }
    var movies: Driver<[Movie]> { get }
    var didSelectMovie: PublishRelay<Movie> { get }
}
