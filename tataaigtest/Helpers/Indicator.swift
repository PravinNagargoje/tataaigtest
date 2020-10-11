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
        self.activityIndicator.style = UIActivityIndicatorView.Style.large
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
