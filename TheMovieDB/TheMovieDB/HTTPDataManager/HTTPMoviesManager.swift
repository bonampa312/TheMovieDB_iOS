//
//  HTTPMoviesManager.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/14/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation
import Alamofire

class HTTPMoviesManager {
    
    static func searchMovies(url: String, query : String, page : Int = 1, completion: @escaping ([String: Any]) -> ()) {
        
        let apiKey = ApplicationConstants.theMovieDBAPIKey
        let searchMovieByNameURL = url
        
        Alamofire.request(
            searchMovieByNameURL,
            parameters : [
                "api_key" : apiKey,
                "query" : query,
                "page" : 1
            ]
            ).responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    completion([String: Any]())
                    return
                }
                
                guard let responseJSON = response.result.value as? [String : Any] else {
                    print("Invalid tag information received from the service")
                    completion([String: Any]())
                    return
                }
                
                completion(responseJSON)
                
        }
    }
}
