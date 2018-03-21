//
//  MovieData.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/13/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation

class MovieData : Movie {
    var title: String
    var releaseDate: String
    var overview: String
    var voteAverage: Double
    var posterPath: String
    var backdropPath: String
    
    init(title: String?, releaseDate: String?, overview: String?, voteAverage: Double?, posterPath: String?, backdropPath: String?) {
        self.title = title ?? ""
        self.releaseDate = releaseDate ?? ""
        self.overview = overview ?? ""
        self.voteAverage = voteAverage ?? 0.0
        self.posterPath = posterPath ?? ""
        self.backdropPath = backdropPath ?? ""
    }
    
    convenience init(jsonMovieObject: [String: Any]) {
        self.init(
            title: (jsonMovieObject["title"]! as? String),
            releaseDate: (jsonMovieObject["release_date"]! as? String),
            overview: (jsonMovieObject["overview"]! as? String),
            voteAverage: (jsonMovieObject["vote_average"]! as? Double),
            posterPath: (jsonMovieObject["poster_path"]! as? String),
            backdropPath: (jsonMovieObject["backdrop_path"]! as? String)
        )
    }
}
