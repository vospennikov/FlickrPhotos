//
//  Photos.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import Foundation

struct SearchPhoto: Codable {
    let photos: Photos
    let stat: String
}

extension SearchPhoto {
    static func resource(apiKey: String, endPoint: URL, page: Int, text: String) -> Resource<SearchPhoto>? {
        let params = [
            "method": "flickr.photos.search",
            "format": "json",
            "content_type": "1",
            "media": "photos",
            "text": text,
            "continuation": "0",
            "api_key": apiKey,
            "page": "\(page)",
            "nojsoncallback": "1"
        ]
        let url = endPoint.appendingQueryParameters(params)
        
        return try? Resource<SearchPhoto>(url: url!) { data in
            let decoder = JSONDecoder()
            return try? decoder.decode(SearchPhoto.self, from: data)
        }
    }
}

struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

extension Photos: GalleryPresentable {
    var numberOfItems: Int {
        return photo.count
    }
    
    var objects: [GalleryCellPresentable] {
        return photo
    }
    
    var currentPage: Int {
        return page
    }
}

struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

extension Photo: GalleryCellPresentable {
    var url: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_q.jpg")!
    }
}
