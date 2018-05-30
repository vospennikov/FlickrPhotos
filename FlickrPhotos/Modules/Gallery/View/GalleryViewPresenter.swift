//
//  GalleryViewPresenter.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import Foundation

protocol GalleryPresentable {
    var numberOfItems: Int { get }
    var objects: [GalleryCellPresentable] { get }
    var currentPage: Int { get }
}

extension GalleryPresentable {
    var currentPage: Int {
        return 0
    }
}

protocol GalleryCellPresentable {
    var url: URL { get }
}
