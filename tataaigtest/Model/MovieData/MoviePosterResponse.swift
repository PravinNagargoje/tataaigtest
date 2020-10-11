//
//  MoviePosterResponse.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import Foundation
import ObjectMapper

class MoviePosterResponse: Mappable {
    
    var id : Int?
    var backdrops: [MoviePosterData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        backdrops <- map["backdrops"]
    }
}
