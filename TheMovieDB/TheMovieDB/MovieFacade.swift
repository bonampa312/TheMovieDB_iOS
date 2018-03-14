//
//  MovieFacade.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation

class MovieFacade {
    
    static func searchMoviesBy(name: String, page: Int, completion : @escaping (MovieList?) -> ()) {
        HTTPMoviesManager.searchMovieByName(query: name.isEmpty ? "Finding Nemo" : name, page: 1, completion: { moviesResponse in
            if !moviesResponse.isEmpty {
                completion(MovieList(jsonObject: moviesResponse))
            } else {
                completion(nil)
            }
        })
    }
    
}
