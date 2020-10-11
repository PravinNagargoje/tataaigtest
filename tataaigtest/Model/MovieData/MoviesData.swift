//
//  MoviesData.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper
import UIKit

class MovieData: Mappable {
   
    var movieType: String?
    var title : String?
    var releaseDate : Date?
    var adult : Bool?
    var id : Int?
    var originalTitle : String?
    var originalLanguage : String?
    var popularity : Int?
    var averageVote : Int?
    var poster : URL?
    var overview : String?
    
    init() {
        
    }
    
    convenience required init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        title               <- map["title"]
        releaseDate         <- (map["release_date"], AppFormatter.dateTransform)
        adult               <- map["adult"]
        id                  <- map["id"]
        originalTitle       <- map["original_title"]
        originalLanguage    <- map["original_language"]
        popularity          <- map["popularity"]
        averageVote         <- map["vote_average"]
        poster              <- (map["poster_path"], AppFormatter.urlTransform)
        overview            <- map["overview"]
    }
    
    func getMovie(type: String) -> Movie {
        
        let movie = Movie()
        movie.movieType = type
        movie.title = self.title
        movie.releaseDate = self.releaseDate
        movie.originalTitle = self.originalTitle
        movie.originalLanguage = self.originalLanguage
        movie.poster = self.poster?.absoluteString
        movie.overview = self.overview
        if let id = self.id {
            movie.id = id
        }
        if let adult = self.adult {
            movie.adult = adult
        }

        if let popularity = self.popularity {
            movie.popularity = popularity
        }
        if let avgVote = self.averageVote {
            movie.averageVote = avgVote
        }
        
        return movie
    }
}
