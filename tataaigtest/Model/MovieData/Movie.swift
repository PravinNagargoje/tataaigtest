//
//  Movie.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class Movie: Object {
    
    @objc dynamic var movieType: String?
    @objc dynamic var title: String?
    @objc dynamic var releaseDate: Date?
    @objc dynamic var adult: Bool = false
    @objc dynamic var id: Int = 0
    @objc dynamic var originalTitle: String?
    @objc dynamic var originalLanguage: String?
    @objc dynamic var popularity : Int = 0
    @objc dynamic var averageVote : Int = 0
    @objc dynamic var poster : String?
    @objc dynamic var overview : String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func getMovieData() -> MovieData {
        
        let movieData = MovieData()
        movieData.movieType = self.movieType
        movieData.title = self.title
        movieData.releaseDate = self.releaseDate
        movieData.adult = self.adult
        movieData.id = self.id
        movieData.originalTitle = self.originalTitle
        movieData.originalLanguage = self.originalLanguage
        movieData.popularity = self.popularity
        movieData.averageVote = self.averageVote
        if let image = poster {
            movieData.poster = URL(string: image)
        }
        
        movieData.overview = self.overview
        
        return movieData
    }
}
