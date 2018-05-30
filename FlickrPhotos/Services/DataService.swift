//
//  DataService.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import Foundation

struct DataService: NetworkService {
    private var cache = MemoryCacheService()
    
    func get<T>(_ resource: Resource<T>, isCached: Bool = false, id: Int? = nil, completion: @escaping (T?) -> Void) -> URLSessionDataTask? {
        
        if isCached, let cachedData = cache.load(resource, cacheKey: String(describing: id)) {
            completion(cachedData)
            return nil
            
        } else {
            
            return load(resource, completion: {
                if isCached {
                    self.cache.save($0 as AnyObject, with: String(describing: id))
                }
                completion($0)
            })
        }
    }
}
