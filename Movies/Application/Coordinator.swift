//
//  Coordinator.swift
//  Movies
//
//  Created by Garnik Harutyunyan on 15/10/2020.
//  Copyright © 2020 Garnik Harutyunyan. All rights reserved.
//

import UIKit

final class Coordinator {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewController = UIViewController()

        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
