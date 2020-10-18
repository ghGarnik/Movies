//
//  Coordinator.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 15/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class Coordinator {
    //MARK: - Init

    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    private let didSelectMovie = PublishRelay<Movie>()
    private let disposeBag = DisposeBag()

    init(window: UIWindow) {
        self.window = window
    }

    //MARK: - Coordinator Methods
    func start() {
        let navigationController = UINavigationController(rootViewController: initialViewController())
        self.navigationController = navigationController

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func initialViewController() -> UIViewController {
        let service = MovieListService(apiClient: APIClient())
        let dataProvider = MovieRepository(service: service)

        let movieListViewModel = MovieListViewModel(repository: dataProvider, selectedMovieRelay: didSelectMovie)
        let movieListViewController = MovieListViewController(viewModel: movieListViewModel)
        subscribeToMovieSelection()
        return movieListViewController

    }

    private func subscribeToMovieSelection() {
        didSelectMovie
            .subscribe(onNext: { [weak self] movie in
                guard let self = self else { return }

                let movieDetailService = MovieDetailService(apiClient: APIClient())
                let movieDetailRepository = MovieDetailRepository(service: movieDetailService)

                let movieDetailViewModel = MovieDetailViewModel(repository: movieDetailRepository, movieId: movie.id)

                let movieDetailViewController = MovieDetailViewController(viewModel: movieDetailViewModel)
                self.navigationController?.pushViewController(movieDetailViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
