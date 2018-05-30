//
//  AppDelegate.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: Coordinator?
    var appearance: AppearanceService?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        setupAppearance()
        startAppCoordinator(window)
        
        return true
    }
    
    private func setupAppearance() {
        appearance = AppearanceService()
        appearance?.setup()
    }
    
    private func startAppCoordinator(_ window: UIWindow) {
        let appCoordinator = AppCoordinator(window: window)
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
}
