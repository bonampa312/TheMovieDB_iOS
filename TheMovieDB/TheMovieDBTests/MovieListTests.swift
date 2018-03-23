//
//  MovieListTests.swift
//  TheMovieDBTests
//
//  Created by Santiago Romero Restrepo on 3/21/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import XCTest
@testable import TheMovieDB

class MovieListTests: XCTestCase {
    
    var listData : MovieList!
    var listDataJSON : [String : Any]!
    var moviesData : [Movie]!
    
    override func setUp() {
        super.setUp()
        listDataJSON = [
            "total_results": 2,
            "total_pages": 1,
            "results": [
                [
                    "vote_average": 7.4,
                    "title": "Thor: Ragnarok",
                    "poster_path": "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg",
                    "backdrop_path": "/kaIfm5ryEOwYg8mLbq8HkPuM1Fo.jpg",
                    "overview": "Thor is imprisoned on the other side of the universe and finds himself in a race against time to get back to Asgard to stop Ragnarok, the prophecy of destruction to his homeworld and the end of Asgardian civilization, at the hands of an all-powerful new threat, the ruthless Hela.",
                    "release_date": "2017-10-25"
                ]
            ]
        ]
        moviesData = [Movie]()
        if let movies = listDataJSON["results"] as? [[String: Any]] {
            for movie in movies {
                moviesData.append(MovieData(jsonMovieObject: movie))
            }
        }
    }
    
    override func tearDown() {
        listDataJSON = nil
        listData = nil
        moviesData = nil
        super.tearDown()
    }
    
    func testTotalPagesOnCreateListWithAllJSONData() {
        listData = MovieList(jsonObject: listDataJSON)
        XCTAssertEqual(listData.totalPages, listDataJSON["total_pages"] as? Int,
                       "Error creating the list, wrong value for total pages")
    }
    
    func testTotalResultsOnCreateListWithAllJSONData() {
        listData = MovieList(jsonObject: listDataJSON)
        XCTAssertEqual(listData.totalResults, listDataJSON["total_results"] as? Int,
                       "Error creating the list, wrong value for total results")
    }
    
    func testMovieListOnCreateListWithAllJSONData() {
        listData = MovieList(jsonObject: listDataJSON)
        XCTAssertEqual(listData.movies! as! [MovieData], moviesData as! [MovieData],
                       "Error creating the list, wrong value for movies list")
    }
    
    func testCreateListWithoutTotalResultsOnJSONData() {
        listDataJSON.removeValue(forKey: "total_results")
        listData = MovieList(jsonObject: listDataJSON)
        XCTAssertEqual(listData.totalPages, 0,
                       "Error creating the list, no total pages because of nil")
    }
    
    func testCreateListWithEmptyResultsOnJSONData() {
        listDataJSON["results"] = []
        listData = MovieList(jsonObject: listDataJSON)
        moviesData = [Movie]()
        XCTAssertEqual(listData.movies! as! [MovieData], moviesData! as! [MovieData],
                       "Error creating the list, no results because of empty")
    }
    
    func testCreateListWithEmptyJSONData() {
        listDataJSON = [:]
        listData = MovieList(jsonObject: listDataJSON)
        moviesData = [Movie]()
        XCTAssertTrue(
            listData.movies! as! [MovieData] == moviesData! as! [MovieData] &&
                listData.totalPages == 0 &&
                listData.totalResults == 0,
            "Error creating the list, no list because of empty json")
    }
    
    func testCreateListWithNilJSONData() {
        listDataJSON = nil
        listData = MovieList(jsonObject: listDataJSON)
        moviesData = [Movie]()
        XCTAssertTrue(
            listData.movies! as! [MovieData] == moviesData! as! [MovieData] &&
                listData.totalPages == 0 &&
                listData.totalResults == 0,
            "Error creating the list, no list because of nil json")
    }
}
