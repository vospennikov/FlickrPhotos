//
//  GalleryViewController.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

final class GalleryViewController: UIViewController, GalleryViewInteraction {
    var coordinator: Coordinator?
    var dataService: DataService?
    var settings: NetworkSettings?
    var itemsPerRow: Int?
    private var galleryViewBinding: GalleryViewBinding?
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        return UICollectionViewFlowLayout(parentViewSize: view.bounds.size, itemsPerRow: itemsPerRow ?? 0)
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(ImageViewCell.self)
        collectionView.backgroundColor = .black
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .always
        }
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        guard let dataService = dataService, let settings = settings, let itemsPerRow = itemsPerRow else {
            return
        }
        galleryViewBinding = GalleryViewBinding(with: collectionView,
                                                dataService: dataService,
                                                settings: settings,
                                                itemsPerRow: itemsPerRow)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
