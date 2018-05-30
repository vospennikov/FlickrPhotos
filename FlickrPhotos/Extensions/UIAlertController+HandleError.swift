//
//  UIAlertController+HandleError.swift
//  TestProject
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func handleError(error: AppError) {
        show(title: error.description, message: nil)
    }
    
    class func handleError(error: String) {
        show(title: error, message: nil)
    }
    
    class func show(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            UIApplication.shared.keyWindow?.rootViewController?.topPresentedViewController.present(alert, animated: true, completion: nil)
        }
    }
}
