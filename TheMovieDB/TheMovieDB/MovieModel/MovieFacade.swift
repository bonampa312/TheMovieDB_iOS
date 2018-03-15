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
        let searchByNameURL = ApplicationConstants.theMovieDBSearchByMovieNameURL
        let query = name.isEmpty ? "Finding Nemo" : name
        HTTPMoviesManager.searchMovies(url: searchByNameURL, query: query, page: 1, completion: { moviesResponse in
            if !moviesResponse.isEmpty {
                completion(MovieList(jsonObject: moviesResponse))
            } else {
                completion(nil)
            }
        })
    }
    
    static func searchMoviesBy(listTitle list: String, page: Int, completion : @escaping (MovieList?) -> ()) {
        
        var listURL : String = ""
        let query = ""
        
        switch (list) {
        case "Now":
            listURL = ApplicationConstants.theMovieDBGetNowPlayingURL
        case "Popular":
            listURL = ApplicationConstants.theMovieDBGetPopularURL
        case "Top":
            listURL = ApplicationConstants.theMovieDBGetTopRatedURL
        case "Soon":
            listURL = ApplicationConstants.theMovieDBGetUpcomingURL
        default:
            break
        }
        HTTPMoviesManager.searchMovies(url: listURL, query: query, page: 1, completion: { moviesResponse in
            if !moviesResponse.isEmpty {
                completion(MovieList(jsonObject: moviesResponse))
            } else {
                completion(nil)
            }
        })
    }
    
}
