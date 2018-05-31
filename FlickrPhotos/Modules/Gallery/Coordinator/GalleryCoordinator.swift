//
//  GalleryCoordinator.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

final class GalleryCoordinator: Coordinator {
    private var presentingController: UINavigationController
    
    private lazy var sceneViewController: UIViewController = {
        let controller = GalleryViewController()
        controller.coordinator = self
        controller.dataService = DataService()
        controller.settings = FlickrSettings()
        controller.itemsPerRow = 6
        return controller
    }()
    
    init(presentingController: UINavigationController) {
        self.presentingController = presentingController
    }
    
    func start() {
        presentingController.pushViewController(sceneViewController, animated: true)
    }
}
