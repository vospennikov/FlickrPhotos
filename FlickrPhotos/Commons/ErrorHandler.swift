//
//  ErrorHandler.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

enum AppError: Error, CustomStringConvertible {
    case apiNoData
    
    var description: String {
        switch self {
        case .apiNoData:
            return "No data."
        }
    }
}

protocol View: class {
    func showError(error: AppError)
    func showError(error: String)
}

extension View {
    func showError(error: AppError) {
        UIAlertController.handleError(error: error)
    }
    
    func showError(error: String) {
        UIAlertController.handleError(error: error)
    }
}
