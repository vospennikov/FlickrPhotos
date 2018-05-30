//
//  MemoryCacheService.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

struct MemoryCacheService {
    private let cache = NSCache<NSString, AnyObject>()
    
    func load<T>(_ resource: Resource<T>, cacheKey: String?) -> T? {
        guard let cacheKey = cacheKey else {
            return nil
        }
        
        return cache.object(forKey: cacheKey.sha512 as NSString) as? T
    }
    
    func save(_ object: AnyObject, with cacheKey: String) {
        cache.setObject(object, forKey: cacheKey.sha512 as NSString)
    }
    
    func flush() {
        cache.removeAllObjects()
    }
}
