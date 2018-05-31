//
//  GalleryViewBinding.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

final class GalleryViewBinding: NSObject, GalleryViewInteraction {
    private var collectionView: UICollectionView
    private let settings: NetworkSettings
    private var dataService: DataService
    
    private let debugRequest = "pentacon six"
    private var objects: [GalleryCellPresentable] = []
    private var currentPage = 0
    private var nextPage: Int {
        return currentPage + 1
    }
    
    private var isNeedUpdate = true
    private var itemsPerRow: Int
    private var fiveRows: Int {
        return itemsPerRow * 5
    }
    
    init(with view: UICollectionView, dataService: DataService, settings: NetworkSettings, itemsPerRow: Int) {
        self.collectionView = view
        self.itemsPerRow = itemsPerRow
        self.dataService = dataService
        self.settings = settings
        
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadData(dataService, settings: settings, text: debugRequest) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.update(item: $0)
        }
    }
    
    func update(item: GalleryPresentable) {
        currentPage = item.currentPage
        
        let indexesPath = Array(objects.count..<item.objects.count + objects.count).map { IndexPath(item: $0, section: 0) }
        objects.append(contentsOf: item.objects)
        
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexesPath)
        })
        
        isNeedUpdate = true
    }
}

extension GalleryViewBinding: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageViewCell = collectionView.dequeuReusableCell(forIndexPath: indexPath)
        cell.dataService = dataService
        cell.loadImage(from: objects[indexPath.row], with: indexPath.row)
        return cell
    }
}

extension GalleryViewBinding: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= objects.count - fiveRows && isNeedUpdate {
            isNeedUpdate = false
            loadData(dataService, settings: settings, page: nextPage, text: debugRequest) { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.update(item: $0)
            }
        }
    }
}

extension GalleryViewBinding: UICollectionViewDelegateFlowLayout { }
