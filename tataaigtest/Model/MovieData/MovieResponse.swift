//
//  MovieResponse.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import Foundation
import ObjectMapper

class MoviesResponse: Mappable {
    
    var page : Int?
    var movieDataArray: [MovieData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        movieDataArray <- map["results"]
    }
}
