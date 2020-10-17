//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 16/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    //MARK: - Subviews

    private let imageHeaderView = UIImageView()
    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let yearLabel = UILabel()
    private let genreLabel = UILabel()
    private let budgetLabel = UILabel()
    private let overviewLabel = UILabel()
    private let contentView = UIView()
    private let scrollView = UIScrollView()

    private var views = [String: UIView]()
    private let metrics: [String: CGFloat] = ["verticalSpacing": 16.0,
                                              "headerHeight": 300]

    //MARK: - Init

    private let movie: Movie

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        self.title = movie.title
        setupViewsDictionary()
    }

    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    //MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fillMovie()
        setupScrollView()
        setupViewConstraints()
        applyStyle()
    }

    private func fillMovie() {
        imageHeaderView.image = UIImage(named: "donnie")
        nameLabel.text = movie.title
        ratingLabel.text = String(movie.rate)+(" %")
        yearLabel.text = String(movie.year)
        genreLabel.text = movie.genre

        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        budgetLabel.text = formatter.string(for: (movie.budget ?? 0.0))

        overviewLabel.text = movie.overview
    }

    //MARK: - VLF methods

    private func setupViewsDictionary() {
        views = ["imageHeaderView": imageHeaderView,
                 "nameLabel": nameLabel,
                 "ratingLabel": ratingLabel,
                 "yearLabel": yearLabel,
                 "genreLabel": genreLabel,
                 "budgetLabel": budgetLabel,
                 "overviewLabel": overviewLabel]
    }

    private func setupScrollView() {
        //Adds scrollView to superView and sets constraints up.
        self.view.addSubViewWithoutConstraints(scrollView)

        let scrollViewDicitonary = ["scrollView": scrollView,
                                    "superView": self.view!,
                                    "contentView": contentView]

        let scrollViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollView]-0-|",
                                                                             options: [],
                                                                             metrics: nil,
                                                                             views: scrollViewDicitonary)

        let scrollViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scrollView]-0-|",
                                                                           options: [],
                                                                           metrics: nil,
                                                                           views: scrollViewDicitonary)

        NSLayoutConstraint.activate(scrollViewHorizontalConstraints+scrollViewVerticalConstraints)

        //Adds contentView to scrollView and sets constraints up.
        scrollView.addSubViewWithoutConstraints(contentView)
        let contentViewHorizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[contentView(==scrollView)]-0-|",
                                                                             options: [],
                                                                             metrics: nil,
                                                                             views: scrollViewDicitonary)

        let contentViewVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[contentView]-0-|",
                                                                                    options: [],
                                                                                    metrics: nil,
                                                                                    views: scrollViewDicitonary)

        NSLayoutConstraint.activate(contentViewHorizontalConstraint+contentViewVerticalConstraint)
    }

    private func setupViewConstraints() {
        views.map { $0.value }.forEach { contentView.addSubViewWithoutConstraints($0) }
        
        var constraints = [NSLayoutConstraint]()

        let mainVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageHeaderView(headerHeight@750)]-verticalSpacing-[nameLabel]-verticalSpacing-[ratingLabel]-verticalSpacing-[genreLabel]-verticalSpacing-[overviewLabel]-verticalSpacing-|",
                                                                     options: [.alignAllCenterX],
                                                                     metrics: metrics,
                                                                     views: views)
        constraints += mainVerticalConstraints

        let yearRowAlignment  = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[yearLabel]-(>=8)-[genreLabel]-(>=8)-[budgetLabel]-|",
                                                               options: [.alignAllCenterY],
                                                               metrics: nil,
                                                               views: views)
        constraints += yearRowAlignment

        let imageHeaderViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageHeaderView]-|",
                                                                                  options: [],
                                                                                  metrics: nil,
                                                                                  views: views)
        constraints += imageHeaderViewHorizontalConstraints

        let nameLabelHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[nameLabel]-|",
                                                                            options: [],
                                                                            metrics: nil,
                                                                            views: views)
        constraints += nameLabelHorizontalConstraints

        let overviewLabelHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[overviewLabel]-|",
                                                                            options: [],
                                                                            metrics: nil,
                                                                            views: views)
        constraints += overviewLabelHorizontalConstraints

        NSLayoutConstraint.activate(constraints)
    }


    //MARK: - View Style

    private func applyStyle() {
        self.view.backgroundColor = .white

        imageHeaderView.contentMode = .scaleAspectFit
        imageHeaderView.clipsToBounds = true

        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.sizeToFit()

        ratingLabel.textColor = .black
        ratingLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        ratingLabel.textAlignment = .center
        ratingLabel.sizeToFit()

        yearLabel.textColor = .black
        yearLabel.font = .systemFont(ofSize: 16, weight: .regular)
        yearLabel.textAlignment = .left
        yearLabel.sizeToFit()

        genreLabel.textColor = .black
        genreLabel.font = .systemFont(ofSize: 16, weight: .regular)
        genreLabel.textAlignment = .center
        genreLabel.numberOfLines = 2
        genreLabel.sizeToFit()

        overviewLabel.textColor = .black
        overviewLabel.font = .systemFont(ofSize: 16, weight: .light)
        overviewLabel.textAlignment = .justified
        overviewLabel.numberOfLines = 0
        overviewLabel.sizeToFit()
    }
}
