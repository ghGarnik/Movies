//
//  MovieListViewController.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 16/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieListViewController: UIViewController {
    //MARK: - Subviews

    private let movieListTableView = UITableView()

    private var views = [String: UIView]()

    //MARK: - Init

    private let disposeBag = DisposeBag()
    private let viewModel: MovieListViewModelProtocol

    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel

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
        setupBindings()
    }

    private func setupTableView() {
        movieListTableView.rowHeight = 200.0
        movieListTableView.separatorStyle = .none
        movieListTableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }

    private func setupBindings() {
        viewModel.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        viewModel.movies
            .drive(movieListTableView.rx.items(cellIdentifier: MovieCell.reuseIdentifier, cellType: MovieCell.self)) {_, movie, cell in
                cell.configureCell(movie: movie)
            }
            .disposed(by: disposeBag)

        movieListTableView.rx.modelSelected(Movie.self)
            .bind(to: viewModel.didSelectMovie)
            .disposed(by: disposeBag)
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
