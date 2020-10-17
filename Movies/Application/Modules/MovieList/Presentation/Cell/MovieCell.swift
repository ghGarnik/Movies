//
//  MovieCell.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 16/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import UIKit
import Kingfisher

final class MovieCell: UITableViewCell {
    static let reuseIdentifier = "movieCell"

     //MARK: - Subviews

    private let coverImageView = UIImageView()
    private let nameLabel = UILabel()
    private let yearLabel = UILabel()
    private let ratingLabel = UILabel()

    private var views = [String: UIView]()

    //MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewsDictionary()
        applyStyle()
        setupViewConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        nameLabel.text = nil
        yearLabel.text = nil
        ratingLabel.text = nil
    }

    func configureCell(movie: Movie) {
        coverImageView.kf.setImage(with: movie.posterUrl)
        nameLabel.text = movie.title
        yearLabel.text = movie.year
        ratingLabel.text = String(movie.rate)+(" %")
    }

    //MARK: - VLF methods

    private func setupViewsDictionary() {
        views = ["nameLabel": nameLabel,
                 "yearLabel": yearLabel,
                 "ratingLabel": ratingLabel,
                 "coverImageView": coverImageView]
    }

    private func setupViewConstraints() {
        self.addSubViewWithoutConstraints(coverImageView)
        self.addSubViewWithoutConstraints(nameLabel)
        self.addSubViewWithoutConstraints(yearLabel)
        self.addSubViewWithoutConstraints(ratingLabel)


        var constraints = [NSLayoutConstraint]()

        let subtitleHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[yearLabel]-(>=16)-[ratingLabel]-16-|",
                                                                           options: [.alignAllCenterY],
                                                                           metrics: nil,
                                                                           views: views)
        constraints += subtitleHorizontalConstraints

        let yearLabelVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[nameLabel]-16-[yearLabel]-16-|",
                                                                          options: [],
                                                                          metrics: nil,
                                                                          views: views)
        constraints += yearLabelVerticalConstraints

        let nameLabelXCenterConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[nameLabel]-|",
                                                                        options: [],
                                                                        metrics: nil,
                                                                        views: views)
        constraints += nameLabelXCenterConstraint


        let coverImageViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[coverImageView]-|",
                                                                                 options: [],
                                                                                 metrics: nil,
                                                                                 views: views)
        constraints += coverImageViewHorizontalConstraints

        let coverImageViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[coverImageView]-|",
                                                                               options: [],
                                                                               metrics: nil,
                                                                               views: views)
        constraints += coverImageViewVerticalConstraints


        NSLayoutConstraint.activate(constraints)
        
    }

     //MARK: - View Style

    private func applyStyle() {
        self.selectionStyle = .none
        
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        
        nameLabel.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.sizeToFit()
        
        yearLabel.backgroundColor = .white
        yearLabel.textColor = .black
        yearLabel.font = .systemFont(ofSize: 16, weight: .light)
        yearLabel.textAlignment = .left
        yearLabel.sizeToFit()
        
        ratingLabel.backgroundColor = .yellow
        ratingLabel.textColor = .black
        ratingLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        ratingLabel.textAlignment = .right
        ratingLabel.sizeToFit()
    }
}
