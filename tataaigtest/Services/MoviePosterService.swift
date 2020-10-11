//
//  MoviePosterService.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import Foundation
import Alamofire
import AlamofireObjectMapper
import RealmSwift

protocol MoviePosterServiceDelegate {
    
    func didFetch(moviePosters: Array<MoviePosterData>)
    func didOccurError(error: String)
}

struct MoviePosterService {
    
    var delegate: MoviePosterServiceDelegate?
    
    func getMovies(moviePosterId : Int?) {
       if let moviePID = moviePosterId {
        let URL = "https://api.themoviedb.org/3/movie/\(moviePID)/images?api_key=eae177ee8e2fe4a0cfcb3de685d8e0d2"
        
        Alamofire.request(URL).responseObject { (response: DataResponse<MoviePosterResponse>) in
            if let moviePosterArray = response.result.value?.backdrops {
                //Thread.sleep(forTimeInterval: 2)
                
                    self.delegate?.didFetch(moviePosters: moviePosterArray)
                }
            }
        }
    }
}
