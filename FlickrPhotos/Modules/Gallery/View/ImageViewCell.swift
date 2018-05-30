//
//  ImageViewCell.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

final class ImageViewCell: UICollectionViewCell {
    private var dataTask: URLSessionDataTask?
    var dataService: DataService?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = contentView.bounds
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.frame = contentView.bounds
        imageView.image = nil
        dataTask?.cancel()
    }
    
    func loadImage(from model: GalleryCellPresentable, with id: Int) {
        do {
            let resource = try Resource<UIImage>(url: model.url, parce: { return UIImage(data: $0) })
            dataTask = dataService?.get(resource, isCached: true, id: id, completion: {
                self.imageView.image = $0
            })
        } catch let error {
            print(error)
        }
    }
}
