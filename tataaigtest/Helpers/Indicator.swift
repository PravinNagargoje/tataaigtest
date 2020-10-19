//
//  Indicator.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MyIndicator: NSObject {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
  
    func StartActivityIndicator(obj:UIView) {
        if #available(iOS 13.0, *) {
            self.activityIndicator.style = UIActivityIndicatorView.Style.large
        } else {
            self.activityIndicator.style = .whiteLarge
            // Fallback on earlier versions
        }
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.center = obj.center
        obj.addSubview(self.activityIndicator)
        self.activityIndicator.backgroundColor = UIColor.gray
        self.activityIndicator.startAnimating()
    }
    
    func StopActivityIndicator() -> Void {
        activityIndicator.stopAnimating()
    }
}
