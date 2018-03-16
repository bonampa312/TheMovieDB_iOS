//
//  ApplicationConstants.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation

class ApplicationConstants {
    
    static let theMovieDBAPIKey : String = "1f4d7de5836b788bdfd897c3e0d0a24b"
    static let theMovieDBAPIBaseURL : String = "https://api.themoviedb.org/3"
    static let theMovieDBAPIMoviePosterURL : String = "https://image.tmdb.org/t/p/w154"
    
    static let theMovieDBSearchByMovieNameURL : String = theMovieDBAPIBaseURL+"/search/movie"
    static let theMovieDBGetLatestURL : String = theMovieDBAPIBaseURL+"/movie/latest"
    static let theMovieDBGetNowPlayingURL : String = theMovieDBAPIBaseURL+"/movie/now_playing"
    static let theMovieDBGetPopularURL : String = theMovieDBAPIBaseURL+"/movie/popular"
    static let theMovieDBGetTopRatedURL : String = theMovieDBAPIBaseURL+"/movie/top_rated"
    static let theMovieDBGetUpcomingURL : String = theMovieDBAPIBaseURL+"/movie/upcoming"
    
}
