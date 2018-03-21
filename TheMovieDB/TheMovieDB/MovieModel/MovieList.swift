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

    init?( jsonObject : [String : Any] ) {
        self.movies = [Movie]()
        if let moviesListResponse = jsonObject["results"] as? [[String : Any]] {
            self.totalPages = jsonObject["total_pages"]! as? Int
            self.totalResults = jsonObject["total_results"]! as? Int
            for movie in moviesListResponse {
                self.movies!.append(
                    MovieData( jsonMovieObject: movie )
                )
            }
        }
    }
}
