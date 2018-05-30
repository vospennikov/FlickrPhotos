//
//  UIViewController+Extra.swift
//  TestProject
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import UIKit

extension UIViewController {
    var topPresentedViewController: UIViewController {
        if let controller = presentedViewController, !controller.isBeingDismissed {
            return controller.topPresentedViewController
        }
        return self
    }
}
