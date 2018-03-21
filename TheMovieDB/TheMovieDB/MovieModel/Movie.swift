//
//  Movie.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/13/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation

protocol Movie {
    
    var title : String { get set }
    var releaseDate : String { get set }
    var overview : String { get set }
    var voteAverage : Double { get set }
    var posterPath : String { get set }
    var backdropPath : String { get set }
    
}
