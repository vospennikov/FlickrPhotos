//
//  FlickrSettings.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import Foundation

struct FlickrSettings: NetworkSettings {
    var endPoint = URL(string: "https://api.flickr.com/services/rest/")!
    var key = "2355f0dffa2f14bc596b723183fd1220"
}
