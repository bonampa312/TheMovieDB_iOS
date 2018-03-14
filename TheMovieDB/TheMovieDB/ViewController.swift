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

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var movieNameSearch: UITextField!
    @IBOutlet weak var resultsAmount: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.movieNameSearch.delegate = self
        
        loadingIndicator.isHidden = true
        resultsAmount.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func SearchMovies(_ sender: Any) {
        loadingIndicator.isHidden = false
        resultsAmount.isHidden = true
        resultsAmount.text = ""
        MovieFacade.searchMoviesBy(name: movieNameSearch.text!, page: 1, completion: { moviesByName in
            self.loadingIndicator.isHidden = true
            if let moviesList = moviesByName {
                self.resultsAmount.text = String(describing: moviesList.totalResults!) + " results"
                self.resultsAmount.isHidden = false
                for movie in moviesList.movies! {
                    print(movie.title)
                }
            } else {
                print("No movies to show, error on request")
                self.resultsAmount.text = "An error has occurred, look at the console 😰"
                self.resultsAmount.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
                self.resultsAmount.isHidden = false
            }
        })
    }
}
