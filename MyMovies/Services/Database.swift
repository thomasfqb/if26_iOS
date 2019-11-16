//
//  Database.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 16/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

// Reférence: https://www.youtube.com/watch?v=c4wLS9py1rU

import SQLite

class Database {

    static let shared = Database()
    
    var database: Connection?
    
    // Tables
    let moviesTable = Table("movies")
    // Expressions
    let id = Expression<Int>("id")
    let originalTitle = Expression<String>("originalTitle")
    let posterPath = Expression<String>("posterPath")
    let voteAverage = Expression<Double>("voteAverage")
    let overview = Expression<String>("overview")
    let releaseDate = Expression<String>("releaseDate")
        
    private init() {
        createConnection()
        createTable()
    }
    
    fileprivate func createTable() {
        guard let database = database else { return }
        
        do {
            try database.run(moviesTable.create(block: { (table) in
                table.column(id, primaryKey: true)
                table.column(originalTitle)
                table.column(posterPath)
                table.column(voteAverage)
                table.column(overview)
                table.column(releaseDate)
            }))
        } catch {
          print(error)
        }
    }
    
    
    fileprivate func createConnection() {
           do {
               let documentDirectory = try FileManager.default.url(
                   for: .documentDirectory,
                   in: .userDomainMask,
                   appropriateFor: nil,
                   create: true)
               
               let fileUrl = documentDirectory.appendingPathComponent("movies").appendingPathExtension("sqlite3")
               database = try Connection(fileUrl.path)
               
           } catch {
               print(error)
           }
       }
       
    
    func addMovieToFavorites(_ movie: Movie, completion: @escaping (Bool, Error?) -> ()) {
        guard let database = database else {
            completion(false, nil)
            return
        }
        
        let query = moviesTable.insert(
          id <- movie.id,
          originalTitle <- movie.originalTitle,
          posterPath <- movie.posterPath ?? "",
          voteAverage <- Double(movie.voteAverage),
          overview <- movie.overview,
          releaseDate <- movie.releaseDate
        )
        
        do {
          try database.run(query)
            completion(true, nil)
        } catch {
          completion(false, error)
        }
        
    }
    
    func removeMovieFromFavorites(_ movie: Movie, completion: @escaping (Bool, Error?) -> ()) {
        guard let db = database else {
            completion(false, nil)
            return
        }
        let query = moviesTable.filter(id == movie.id)
        
        do {
          try db.run(query.delete())
          completion(true, nil)
        } catch {
          completion(false, error)
        }
    }
    
    
    func movieIsFavorite(_ movie: Movie) -> Bool {
        guard let db = database else {
            return false
        }
        let query = moviesTable.filter(id == movie.id)
      
      do {
        let count = try db.scalar(query.count)
        return count == 1
      } catch {
        print ("Failed to check favorrite status", error)
        return false
      }
    }
    
    func getFavoritesMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        guard let db = database else { return }
        var movies = [Movie]()
        do {
            let queryResult = try db.prepare(moviesTable)
            for result in queryResult {
                let movie = Movie(
                    id: result[id],
                    originalTitle: result[originalTitle],
                    posterPath: result[posterPath],
                    voteAverage: result[voteAverage],
                    overview: result[overview],
                    releaseDate: result[releaseDate],
                    videos: nil)
                
                movies.append(movie)
                completion(movies, nil)
            }
        } catch {
            completion(movies, error)
        }
    }
    
}
