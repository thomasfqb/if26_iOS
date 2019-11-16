//
//  Result.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import Foundation

struct Result: Decodable {
    
    var movies: [Movie]
    var page: Int
    let totalResults: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page, totalResults, totalPages
    }
    
}
