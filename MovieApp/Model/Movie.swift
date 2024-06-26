//
//  Movie.swift
//  MovieApp
//
//  Created by Faruk on 7.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import Foundation

//"popularity": 332.645,
//"vote_count": 2219,
//"video": false,
//"poster_path": "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
//"id": 419704,
//"adult": false,
//"backdrop_path": "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
//"original_language": "en",
//"original_title": "Ad Astra",
//"genre_ids": [
//  12,
//  18,
//  9648,
//  878,
//  53
//],
//"title": "Ad Astra",
//"vote_average": 6,
//"overview": "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.",
//"release_date": "2019-09-17"

struct Movie:Codable{
    var vote_count: Int?
    var poster_path: String?
    var id: Int?
    var backdrop_path: String?
    var original_title: String?
    var title: String?
    var vote_avarage: Int?
    var overview: String?
    var release_date: String?
}
