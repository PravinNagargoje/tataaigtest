//
//  MovieService.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//


import Foundation
import Alamofire
import AlamofireObjectMapper
import RealmSwift

protocol MovieServiceDelegate {    
    func didFetch(movies: Array<MovieData>)
    func didOccurError(error: String)
}

struct MovieService {
    
    var delegate: MovieServiceDelegate?
    
    func getPopularMovies() {
        let URL = "https://api.themoviedb.org/3/movie/popular?api_key=eae177ee8e2fe4a0cfcb3de685d8e0d2&language=en-US&page=1"
        
        Alamofire.request(URL).responseObject { (response: DataResponse<MoviesResponse>) in
            if let movieDataArray = response.result.value?.movieDataArray {
                //Thread.sleep(forTimeInterval: 2)
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(movieDataArray.map (
                        {$0.getMovie(type: "popular")}
                    ), update: .all)
                }
                
                self.delegate?.didFetch(movies: movieDataArray)
            }
        }
    }
}
