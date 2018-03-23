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
    
    convenience init(jsonMovieObject: [String: Any]?) {
        if let jsonMovie = jsonMovieObject {
            self.init(
                title: (jsonMovie["title"] as? String),
                releaseDate: (jsonMovie["release_date"] as? String),
                overview: (jsonMovie["overview"] as? String),
                voteAverage: (jsonMovie["vote_average"] as? Double),
                posterPath: (jsonMovie["poster_path"] as? String),
                backdropPath: (jsonMovie["backdrop_path"] as? String)
            )
        } else {
            self.init(title: nil, releaseDate: nil, overview: nil, voteAverage: nil, posterPath: nil, backdropPath: nil)
        }
    }
    
}

extension MovieData : Equatable {
    static func ==(lhs: MovieData, rhs: MovieData) -> Bool {
        return (
            lhs.title == rhs.title &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.overview == rhs.overview &&
            lhs.voteAverage == rhs.voteAverage &&
            lhs.posterPath == rhs.posterPath &&
            lhs.backdropPath == rhs.backdropPath
        )
    }
}
