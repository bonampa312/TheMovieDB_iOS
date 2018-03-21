//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/20/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    var movie : Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let movieData = movie else {
            return
        }
        
        backdropImage.af_setImage(withURL: URL(string: ApplicationConstants.theMovieDBAPIMovieBackdropURL+movieData.backdropPath)!)
        posterImage.af_setImage(withURL: URL(string: ApplicationConstants.theMovieDBAPIMoviePosterURL+movieData.posterPath)!)
        movieTitle.text = movieData.title
        overview.text = movieData.overview
        releaseDate.text = "🗓 \(movieData.releaseDate)"
        voteAverage.text = "Votes: \(String(describing: movieData.voteAverage))/10"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDetail))
        view.addGestureRecognizer(tapGesture)
    }
    
    func dismissDetail() {
        self.dismiss(animated: true, completion: nil)
    }

}
