//
//  Movie.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    let id: Int
    let originalTitle: String
    let posterPath: String?
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    var videos: [Video]?
    
}
