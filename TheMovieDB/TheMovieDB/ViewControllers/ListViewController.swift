//
//  ListViewController.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var movies : MovieList?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let movieList = movies {
            for movie in movieList.movies! {
                print(movie.title)
            }
        }
    }

}
