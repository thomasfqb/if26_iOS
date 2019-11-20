//
//  VideosResult.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 19/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import Foundation

struct VideosResult: Decodable {
    
    var results: [Video]
}
