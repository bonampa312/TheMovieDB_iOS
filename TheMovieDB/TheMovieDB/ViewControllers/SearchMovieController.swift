//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/24/17.
//  Updated by Santiago Romero on 3/13/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import Alamofire

class SearchMovieController: UIViewController, UITextFieldDelegate {
    
    private var movies : MovieList?
    @IBOutlet var listsButtons: [UIButton]!
    
    @IBOutlet weak var movieNameSearch: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.movieNameSearch.delegate = self
        
        loadingIndicator.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchMoviesByName()
        return true;
    }
    
    @IBAction func SearchMovies(_ sender: Any) {
        searchMoviesByName()
    }
    
    func searchMoviesByName() {
        loadingIndicator.isHidden = false
        MovieFacade.searchMoviesBy(name: movieNameSearch.text!, page: 1, completion: { moviesByName in
            self.loadingIndicator.isHidden = true
            if let moviesList = moviesByName {
                self.movies = moviesList
                for movie in moviesList.movies! {
                    print(movie.title)
                }
            } else {
                print("No movies to show, error on request")
            }
        })
    }
    
    func searchMoviesList(listToSearch: String) {
        loadingIndicator.isHidden = false
        MovieFacade.searchMoviesBy(listTitle: listToSearch, page: 1, completion: { moviesByList in
            self.loadingIndicator.isHidden = true
            if let moviesList = moviesByList {
                self.movies = moviesList
                for movie in moviesList.movies! {
                    print(movie.title)
                }
            } else {
                print("No movies to show, error on request")
            }
        })
    }

    @IBAction func searchMoviesList(_ sender: UIButton) {
        self.searchMoviesList(listToSearch: (sender.titleLabel?.text)!)
    }
    
}
