//
//  GalleryViewInteraction.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

protocol GalleryViewInteraction: NetworkService {
    func loadData(_ service: DataService, settings: NetworkSettings, page: Int, text: String, with completion: @escaping (GalleryPresentable) -> Void)
}

extension GalleryViewInteraction {
    func loadData(_ service: DataService, settings: NetworkSettings, page: Int = 1, text: String, with completion: @escaping (GalleryPresentable) -> Void) {
        guard let resource = SearchPhoto.resource(apiKey: settings.key, endPoint: settings.endPoint, page: page, text: text) else {
            return
        }
        
        let _ = service.get(resource) { result in
            guard let result = result else {
                UIAlertController.handleError(error: .apiNoData)
                return
            }
            completion(result.photos)
        }
    }
}
