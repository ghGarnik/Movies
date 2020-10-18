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

    var title: Driver<String> {
        .just("Awesome Movies!!")
    }

    func viewDidLoad() {
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

    private func updateMovies(_ load: Update) {
        isLoading = true
        self.repository.movies(forState: currentSearchState.value)
            .subscribe(onSuccess: { [weak self] resultState in
                guard let self = self else { return }

                var mergedState = resultState
                if case .next = load {
                    mergedState.currentMovieList = self.currentSearchState.value.currentMovieList + resultState.currentMovieList
                }

                self.currentSearchState.accept(mergedState)
                self.isLoading = false
            })
            .disposed(by: self.disposeBag)
    }
}
