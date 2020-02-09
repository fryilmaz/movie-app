//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Faruk on 7.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import Foundation

struct MovieDetailResponse: Codable {
    var popularity: Int?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var vote_count: Int?
    var vote_avarage: Int?
    var overview: String?
}
