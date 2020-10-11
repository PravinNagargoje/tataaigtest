//
//  AppHelper.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import Foundation

class AppHelper {
    
    class func getImageURL(usingURL url: URL?) -> URL? {
        var imgUrl: URL?
        if let url = url {
            imgUrl = URL(string: "http://image.tmdb.org/t/p/w185/\(url.absoluteString)")
        }
        
        return imgUrl
    }
}
