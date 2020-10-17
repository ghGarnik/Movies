//
//  Coordinator.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 15/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import UIKit

final class Coordinator {
    //MARK: - Init

    private let window: UIWindow
    private var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    //MARK: - Coordinator Methods
    func start() {
        let movieListviewController = MovieListViewController(dataProvider: DataProvider(), didSelectMovie: didSelectMovie)
        let navigationController = UINavigationController(rootViewController: movieListviewController)
        self.navigationController = navigationController


        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func didSelectMovie(_ movie: Movie) {
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
