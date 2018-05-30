//
//  UICollectionViewFlowLayout+SquareTile.swift
//  TestProject
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    convenience init(parentViewSize: CGSize,
                     itemsPerRow: Int,
                     sectionInset: UIEdgeInsets = .zero,
                     minimumLineSpacing: CGFloat = 0,
                     minimumInteritemSpacing: CGFloat = 0) {
        self.init()
        
        let sideSize = parentViewSize.width / CGFloat(itemsPerRow)
        
        itemSize = CGSize(width: sideSize, height: sideSize)
        self.sectionInset = sectionInset
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }
}
