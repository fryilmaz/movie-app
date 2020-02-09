
//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Faruk on 8.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import Foundation

struct MovieResponse:Decodable{
    var results: Array<Movie> = []
    
}
