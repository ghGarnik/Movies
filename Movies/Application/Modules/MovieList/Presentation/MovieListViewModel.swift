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

class MovieListViewModel {
    //MARK: - Init

    private enum Update {
        case initial
        case next
    }

    private let currentSearchState = BehaviorRelay<MovieListSearchState>(value: MovieListSearchState(searchText: ""))
    private let disposeBag = DisposeBag()
    private var isLoading = false

    private let selectedMovieRelay: PublishRelay<Movie>
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol, selectedMovieRelay: PublishRelay<Movie>) {
        self.repository = repository
        self.selectedMovieRelay = selectedMovieRelay
    }
}

extension MovieListViewModel: MovieListViewModelProtocol {
    func refreshMovies() {
        currentSearchState.accept(currentSearchState.value.resetingState().withQuery(""))
        updateMovies(.initial)
    }

    func searchMovie(searchQuery: String) {
        let searchState = currentSearchState.value
        .resetingState()
        .withQuery(searchQuery)

        currentSearchState.accept(searchState)
        updateMovies(.initial)
    }

    var movies: Driver<[Movie]> {
        currentSearchState
            .map({ $0.currentMovieList })
            .asDriver(onErrorJustReturn: [])
    }

    func loadNextPage() {
        guard !isLoading else { return }

        let currentState = currentSearchState.value
        if currentState.currentPage < currentState.maximumPages {
            self.updateMovies(.next)
        }
    }

    var didSelectMovie: PublishRelay<Movie> {
        selectedMovieRelay
    }

    private func updateMovies(_ update: Update) {
        isLoading = true
        let searchState = update == .initial ? currentSearchState.value.resetingState() : currentSearchState.value

        self.repository.movies(forState: searchState)
            .subscribe(onSuccess: { [weak self] resultState in
                guard let self = self else { return }

                let fullState = update == .next ? resultState.appendingMovies(from: self.currentSearchState.value) : resultState
                self.currentSearchState.accept(fullState)
                self.isLoading = false
            })
            .disposed(by: self.disposeBag)
    }
}
