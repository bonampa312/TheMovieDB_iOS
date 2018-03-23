//
//  MovieDataTests.swift
//  TheMovieDBTests
//
//  Created by Santiago Romero Restrepo on 3/21/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import XCTest
@testable import TheMovieDB

class MovieDataTests: XCTestCase {
    
    var movieData : Movie!
    var movieDataJSON : [String: Any]!
    
    override func setUp() {
        super.setUp()
        movieDataJSON = [
            "vote_average": 7.4,
            "title": "Thor: Ragnarok",
            "poster_path": "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg",
            "backdrop_path": "/kaIfm5ryEOwYg8mLbq8HkPuM1Fo.jpg",
            "overview": "Thor is imprisoned on the other side of the universe and finds himself in a race against time to get back to Asgard to stop Ragnarok, the prophecy of destruction to his homeworld and the end of Asgardian civilization, at the hands of an all-powerful new threat, the ruthless Hela.",
            "release_date": "2017-10-25"
        ]
    }
    
    override func tearDown() {
        movieDataJSON = nil
        movieData = nil
        super.tearDown()
    }
    
    func testVoteAverageOnCreateMovieWithAllJSONData() {
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertEqual(movieData.voteAverage, movieDataJSON["vote_average"] as? Double,
                       "Error creating the movie, wrong value for vote average")
    }
    
    func testTitleOnCreateMovieWithAllJSONData() {
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertEqual(movieData.title, movieDataJSON["title"] as? String,
                       "Error creating the movie, wrong value for title")
    }
    
    func testPosterPathOnCreateMovieWithAllJSONData() {
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertEqual(movieData.posterPath, movieDataJSON["poster_path"] as? String,
                       "Error creating the movie, wrong value for poster path")
    }
    
    func testBackdropPathOnCreateMovieWithAllJSONData() {
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertEqual(movieData.backdropPath, movieDataJSON["backdrop_path"] as? String,
                       "Error creating the movie, wrong value for backdrop path")
    }
    
    func testOverviewOnCreateMovieWithAllJSONData() {
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertEqual(movieData.overview, movieDataJSON["overview"] as? String,
                       "Error creating the movie, wrong value for overview")
    }
    
    func testReleaseDateOnCreateMovieWithAllJSONData() {
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertEqual(movieData.releaseDate, movieDataJSON["release_date"] as? String,
                       "Error creating the movie, wrong value for release date")
    }
    
    func testCreateMovieWithBlankTitleOnJSONData() {
        movieDataJSON["title"] = ""
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertEqual(movieData.title, "",
                       "Error creating the movie, no movie title because of blank")
    }

    func testCreateMovieWithoutTitleOnJSONData() {
        movieDataJSON.removeValue(forKey: "title")
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertEqual(movieData.title, "",
                          "Error creating the movie, no movie title because of nil")
    }
    
    func testCreateMovieWithoutAnyDataOnJSONData() {
        movieDataJSON = [:]
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertTrue(movieData.title == "" && movieData.voteAverage == 0.0 && movieData.releaseDate == "" && movieData.overview == "" && movieData.posterPath == "" && movieData.backdropPath == "",
                      "Error creating the movie, no movie because of blank json")
    }
    
    func testCreateMovieWithNilJSONData() {
        movieDataJSON = nil
        movieData = MovieData(jsonMovieObject: movieDataJSON)
        XCTAssertTrue(movieData.title == "" && movieData.voteAverage == 0.0 && movieData.releaseDate == "" && movieData.overview == "" && movieData.posterPath == "" && movieData.backdropPath == "",
                      "Error creating the movie, no movie because of nil json")
    }
    
}

