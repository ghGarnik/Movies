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
    private let searchController = UISearchController()

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
        setupSearchController()
        setupViewConstraints()
        applyStyle()
        setupBindings()
    }

    private func setupTableView() {
        movieListTableView.rowHeight = 200.0
        movieListTableView.separatorStyle = .none
        movieListTableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
        movieListTableView.keyboardDismissMode = .onDrag

        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing awesome movies")
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        movieListTableView.refreshControl = refreshControl
    }

    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.searchTextField.placeholder = "Tip here to get awesome movies"
        self.navigationController?.navigationBar.topItem?.titleView = searchController.searchBar
    }

    @objc private func refreshTable() {
        searchController.searchBar.searchTextField.text = ""
        viewModel.refreshMovies()
    }

    //MARK: - RxCocoa Bindings

    private func setupBindings() {
        viewModel.movies
            .do(onNext: { [weak self] _ in self?.movieListTableView.refreshControl?.endRefreshing() })
            .drive(movieListTableView.rx.items(cellIdentifier: MovieCell.reuseIdentifier, cellType: MovieCell.self)) {_, movie, cell in
                cell.configureCell(movie: movie)
            }
            .disposed(by: disposeBag)

        searchController.searchBar.rx.text.orEmpty
            .debounce(.microseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe (onNext: { [weak self] query in
                guard let self = self else { return }
                self.viewModel.searchMovie(searchQuery: query)
            })
            .disposed(by: disposeBag)

        movieListTableView.rx.contentOffset
            .subscribe({ [weak self] _ in
                guard let self = self else { return }
                guard self.shouldLoadNextPage else { return }
                self.viewModel.loadNextPage()
            })
            .disposed(by: disposeBag)


        movieListTableView.rx.modelSelected(Movie.self)
            .bind(to: viewModel.didSelectMovie)
            .disposed(by: disposeBag)
    }

    private var shouldLoadNextPage: Bool {
        guard movieListTableView.contentSize.height > movieListTableView.frame.height else { return false }
        
        return  movieListTableView.contentOffset.y + movieListTableView.frame.size.height + 20.0 > movieListTableView.contentSize.height
    }

    private func applyStyle() {
        self.view.backgroundColor = .white
    }

    //MARK: - VFL methods

    private func setupViewsDictionary() {
        views = ["movieListTableView": movieListTableView,
                 "searchBar": searchController.searchBar]
    }

    private func setupViewConstraints() {
        self.view.addSubViewWithoutConstraints(movieListTableView)
        let safeAreaBottom = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0.0)

        var constraints = [NSLayoutConstraint]()

        let tableViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[movieListTableView]-0-|",
                                                                            options: [],
                                                                            metrics: nil,
                                                                            views: views)
        constraints += tableViewHorizontalConstraints

        let tableViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[movieListTableView]-\(safeAreaBottom)-|",
                                                                          options: [],
                                                                          metrics: nil,
                                                                          views: views)
        constraints += tableViewVerticalConstraints

        NSLayoutConstraint.activate(constraints)
    }
}
