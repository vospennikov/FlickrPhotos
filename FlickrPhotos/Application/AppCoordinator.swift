//
//  AppCoordinator.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private lazy var rootViewController: UINavigationController = {
        let controller = UINavigationController()
        controller.isNavigationBarHidden = true
        return controller
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        let galleryCoordinator = GalleryCoordinator(presentingController: rootViewController)
        galleryCoordinator.start()
    }
}
