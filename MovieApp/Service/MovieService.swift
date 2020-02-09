//
//  MovieService.swift
//  MovieApp
//
//  Created by Faruk on 8.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import Foundation

class MovieService:BaseService {
   
    func fetchMovies(pageId: String,completion:@escaping (MovieResponse?,String?)->()){
        let movieUrl =  "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=\(pageId)"
        if let url = URL(string: movieUrl) {
            fetch(url: url) { (response:Result<MovieResponse,ServiceError>) in
                switch response {
                case .success(let data):
                    completion(data,nil)
                case .failure(let error):
                    completion(nil,error.rawValue)
                }
            }
        }
    }
    
    func fetchMovieDetails(movieId:String,completion:@escaping (MovieDetailResponse?,String?)->()){
        let detailUrl = " https://api.themoviedb.org/3/movie/\(movieId)?language=enUS&api_key=fd2b04342048fa2d5f728561866ad52a"
        
        if let url = URL(string: detailUrl) {
            fetch(url: url) { (response:Result<MovieDetailResponse?,ServiceError>) in
                switch response {
                case .success(let data):
                    completion(data,nil)
                case .failure(let error):
                    completion(nil,error.rawValue)
                }
            }
        }
    }
}
