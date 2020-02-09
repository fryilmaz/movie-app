//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Faruk on 8.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import Foundation

enum PresentationStyle{
    case table
    case grid
}

class MoviesViewModel {
    
    var dataSource: [Movie] = []
    var movies:[Movie] = []{
        didSet{
            dataSource = movies
        }
    }
    var selectedMovie = Movie()
    var pageId = 1
    var selectedIndexPath = IndexPath()
    var moviesDidLoadSucceed : (() ->())?
    var moviesDidLoadFailed : ((String) ->())?
    var searchKey = ""
    var presentationStyle = PresentationStyle.grid
    
    private var movieService:MovieService!
    
    init(service:MovieService) {
        self.movieService = service
    }
    
    init() {
        
    }
    func fetchMovies(){
        movieService.fetchMovies(pageId: String(self.pageId)) { (response, error) in
           
           if let response = response {
                self.movies += response.results
                DispatchQueue.main.async {
                    self.moviesDidLoadSucceed?()
                }
                
           }
           else {
                DispatchQueue.main.async {
                   self.moviesDidLoadFailed?(error!)
                }                                
           }
        }
    }
    
    func handleCollectionData() {        
        if searchKey.count > 1 {
            dataSource = self.movies.filter({$0.title!.lowercased().contains(searchKey.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())})
        }
        else{
            dataSource = movies
        }
    }
}
