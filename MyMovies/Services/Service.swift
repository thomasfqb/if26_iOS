//
//  Service.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    private let apiKey = "6bf06b7a537c129fe359973f4cdc31f5"
    private let apiPath = "https://api.themoviedb.org/3"
    
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w400"
    
    
    func fetchUpcomingMovies(page: Int = 1, completion: @escaping (Result?, Error?) -> ()) {
        let urlString = "\(apiPath)/movie/now_playing?api_key=\(apiKey)&page=\(page)"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    
    func fetchMovies(searchTerm: String, page: Int = 1, completion: @escaping (Result?, Error?) -> ()) {
    
        let urlString = "\(apiPath)/search/movie?api_key=\(apiKey)&language=en-US&query=\(searchTerm)&page=\(page)&include_adult=false"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let objects = try decoder.decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
}
