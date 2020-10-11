//
//  Formatters.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import Foundation
import ObjectMapper

class AppFormatter {
    
    static let dateTransform = TransformOf<Date, String>(fromJSON: { (value: String?) -> Date? in
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.date(from: value!)
        
        }, toJSON: { (value: Date?) -> String? in
            
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            return df.string(from: value!)
    })
    
    
    static let urlTransform = TransformOf<URL, String>(fromJSON: { (value: String?) -> URL? in
        var data: URL?
        if let val = value {
            data = URL(string: "\(val)")!
        }
        
        return data
        
        }, toJSON: { (value: URL?) -> String? in
            
            return value!.absoluteString
    })
    
}
