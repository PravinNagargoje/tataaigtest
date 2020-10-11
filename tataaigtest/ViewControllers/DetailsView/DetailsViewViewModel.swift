//
//  DetailsViewViewModel.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class DetailsViewViewModel {
    
    fileprivate var moviePosterService = MoviePosterService()
    fileprivate var moviePosterArray = Array<MoviePosterData>()
        
    fileprivate var movieData : MovieData!
    
    fileprivate var title: String?
    fileprivate var rating: CGFloat?
    fileprivate var date: Date?
    fileprivate var overview: String?
    
    fileprivate let sections : Array = [ "TITLE", "RELEASE DATE", "RATING", "OVERVIEW"]
    fileprivate var DetailsVC : DetailsViewController!
    fileprivate var sectionNumber = 0
    
    init(
        DetailsVC: DetailsViewController,
        movie: MovieData?,
        sectionNo: Int,
        search: Bool? = false
        ) {
        self.DetailsVC = DetailsVC
        self.sectionNumber = sectionNo
        
        if sectionNo == 0 && search == false {
            self.title = movie?.originalTitle
            self.rating = CGFloat(Float(movie?.averageVote ?? 0))
            self.date = movie?.releaseDate
            self.overview = movie?.overview
        }
        self.movieData = movie
        
        self.moviePosterService.delegate =  self
        self.getMoviePosters()
    }
    
    func getSectionCount() -> Int {
        return self.sections.count
    }
    
    func getRowsCount() -> Int {
        return 1
    }
    
    func colletionViewSectionCount() -> Int {
        return 1
    }
    
    func getSections() -> [String] {
        return sections
    }
    
}

extension DetailsViewViewModel {
    
    func getMoviePosters() {
       self.moviePosterService.getMovies(moviePosterId: movieData?.id)
    }
    
    func getArrayCount() -> Int {
        
        return self.moviePosterArray.count
    }
    
    func getTitle() -> String {
        var name = ""
        if let movieTitle = title {
            name = movieTitle
        }
        return name
    }
    
    func getRatings() -> CGFloat {
        var rate : CGFloat = 0.0
        if let starr = rating {
            rate = starr
        }
        return rate
    }
    
    func getOverview() -> String {
        var data = ""
        if let intro = overview {
            data = intro
        }
         return data
    }
    
    func getDate() -> Date? {
        return self.date
    }
    
    func getSectionNumber() -> Int {
        return sectionNumber
    }

//    func getMovieData() -> MovieData {
//        return movieData
//    }
//

    func getMoviePosterArray() -> Array<MoviePosterData> {
        return moviePosterArray
    }
}

extension DetailsViewViewModel: MoviePosterServiceDelegate {
    
    func didFetch(moviePosters: Array<MoviePosterData>) {
        self.moviePosterArray = moviePosters
        self.DetailsVC.reloadView()
    }
    
    func didOccurError(error: String) {
        
    }
}

//extension DetailsViewViewModel: SeasonPosterServiceDelegate {
//
//    func didFetch(seasonPosters seasons: Array<SeasonPosterData>) {
//        self.seasonPosterArray = seasons
//        self.DetailsVC.reloadView()
//    }
//
//    func didErrorOccur(error: String) {
//
//    }
//}
