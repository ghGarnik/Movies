//
//  MovieListViewController.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 16/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
    //MARK: - Subviews

    private let movieListTableView = UITableView()

    private var views = [String: UIView]()

    //MARK: - Init
    
    private let dataProvider: DataProvider
    private let didSelectMovie: (Movie) -> Void

    private var movies = [Movie]() {
        didSet {
            movieListTableView.reloadData()
        }
    }

    init(dataProvider: DataProvider, didSelectMovie: @escaping (Movie) -> Void) {
        self.dataProvider = dataProvider
        self.didSelectMovie = didSelectMovie

        super.init(nibName: nil, bundle: nil)

        self.title = "Awesome Movies!"
        setupViewsDictionary()
    }

    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    //MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewConstraints()
        movies = dataProvider.getMovies()
    }

    private func setupTableView() {
        movieListTableView.dataSource = self
        movieListTableView.delegate = self

        movieListTableView.separatorStyle = .none

        movieListTableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }

    //MARK: - VLF methods

    private func setupViewsDictionary() {
        views = ["movieListTableView": movieListTableView]
    }

    private func setupViewConstraints() {
        self.view.addSubViewWithoutConstraints(movieListTableView)

        var constraints = [NSLayoutConstraint]()

        let tableViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[movieListTableView]-0-|",
                                                                            options: [],
                                                                            metrics: nil,
                                                                            views: views)
        constraints += tableViewHorizontalConstraints

        let tableViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[movieListTableView]-0-|",
                                                                          options: [],
                                                                          metrics: nil,
                                                                          views: views)
        constraints += tableViewVerticalConstraints


        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - TableView

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell,
            movies.indices.contains(indexPath.row) else {
                return UITableViewCell()
        }
        movieCell.configureCell(movie: movies[indexPath.row])
        return movieCell
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard movies.indices.contains(indexPath.row) else { return }
        didSelectMovie(movies[indexPath.row])
    }
}
