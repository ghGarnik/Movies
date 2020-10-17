//
//  UIView+Extensions.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 16/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import UIKit

extension UIView {
    func addSubViewWithoutConstraints(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
}
