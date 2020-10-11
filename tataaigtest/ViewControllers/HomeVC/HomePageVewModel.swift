//
//  HomePageVewModel.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RealmSwift

enum SectionType {
    case movie
    case season
}
class HomePageViewModel {
    
    fileprivate var movieService = MovieService()
    fileprivate var moviesArray: Array<MovieData> = Array<MovieData>()
    fileprivate var homePageVC : HomeScreenVC!
    
    init(homePageVC: HomeScreenVC) {
        self.homePageVC = homePageVC
        self.movieService.delegate = self
        
        fetchPopularMoviesData()
    }
    
    func sortByPopularity() {
        let realm = try! Realm()
        let result = realm.objects(Movie.self).filter("movieType == 'popular'")
        let topRatedResult = result.sorted(byKeyPath: "popularity", ascending: false)
        if topRatedResult.count > 0 {
            self.moviesArray = topRatedResult.map({ $0.getMovieData()})
           self.homePageVC.reloadCollectionView()
        }
    }
    
    func fetchPopularMoviesData() {
        let realm = try! Realm()
        let result = realm.objects(Movie.self).filter("movieType == 'popular'")
        if result.count > 0 {
            self.moviesArray = result.map({ $0.getMovieData() })
            print(moviesArray.map({$0.averageVote}))
            self.homePageVC.reloadCollectionView()
        }
        self.movieService.getPopularMovies()
    }
    
    func sortByRating() {
        let realm = try! Realm()
        let result = realm.objects(Movie.self).filter("movieType == 'popular'")
        let topRatedResult = result.sorted(byKeyPath: "averageVote", ascending: false)
        if topRatedResult.count > 0 {
            self.moviesArray = topRatedResult.map({ $0.getMovieData()})
            self.homePageVC.reloadCollectionView()
        }
    }
    
    func fetchSearchedMovies(movieName: String) {
          let realm = try! Realm()
          let result = realm.objects(Movie.self).filter("movieType == 'popular'")
          let searchedResult = result.filter{ ($0.originalTitle?.contains(movieName) ?? false)}
          if searchedResult.count > 0 {
            self.moviesArray = searchedResult.map({ $0.getMovieData()})
          } else {
            self.moviesArray = []
          }
          self.homePageVC.reloadCollectionView()
      }
    
    func moviesCount() -> Int {
       return self.moviesArray.count
    }
    
    func getMoviesItem(index: Int) -> MovieData {
        return self.moviesArray[index]
    }
    
    func setTitle() -> String {
        return "Movies"
    }
    
    func getCellSpace() -> CGFloat {
        
        return 5.0
    }
}

extension HomePageViewModel: MovieServiceDelegate {
    
    func didFetch(movies: Array<MovieData>) {
        self.moviesArray = movies
        self.homePageVC.reloadCollectionView()
    }
    
    func didOccurError(error: String) {
        
    }
}
