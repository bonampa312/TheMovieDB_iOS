//
//  MovieList.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/13/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation

class MovieList {
    var totalResults : Int?
    var totalPages : Int?
    var movies : [Movie]?

    init(totalResults : Int?, totalPages : Int?, movies : [Movie]?){
        self.totalResults = totalResults ?? 0
        self.totalPages = totalPages ?? 0
        self.movies = movies ?? [Movie]()
    }
    
    convenience init( jsonObject : [String : Any]? ) {
        if let moviesList = jsonObject,
            let moviesListResponse = moviesList["results"] as? [[String : Any]],
            let moviesListTotalResults = moviesList["total_results"] as? Int,
            let moviesListTotalPages = moviesList["total_pages"] as? Int {
            var movies = [Movie]()
            for movie in moviesListResponse {
                movies.append(
                    MovieData( jsonMovieObject: movie )
                )
            }
            self.init(
                totalResults : moviesListTotalResults,
                totalPages : moviesListTotalPages,
                movies : movies
            )
        } else {
            self.init(totalResults : nil, totalPages : nil, movies : nil)
        }
    }
}
