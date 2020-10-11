//
//  MoviePosterData.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import Foundation
import AlamofireObjectMapper
import ObjectMapper

class MoviePosterData: Mappable {

    var poster : URL?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        poster    <- (map["file_path"], AppFormatter.urlTransform)
    }
}
