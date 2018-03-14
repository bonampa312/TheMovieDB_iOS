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
                    MovieData(
                        title: (movie["title"]! as? String),
                        releaseDate: (movie["release_date"]! as? String),
                        overview: (movie["overview"]! as? String),
                        voteAverage: (movie["vote_average"]! as? Double),
                        posterPath: (movie["poster_path"]! as? String)
                    )
                )
            }
        }
    }
}