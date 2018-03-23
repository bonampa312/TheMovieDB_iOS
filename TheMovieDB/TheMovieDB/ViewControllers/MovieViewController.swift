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
import AlamofireImage

class MovieViewController: UIViewController, UITextFieldDelegate {
    
    fileprivate var customList : CustomList!
    var presenter : ListMoviePresenter!

    @IBOutlet weak var changeListButton: UIBarButtonItem!
    @IBOutlet var listsButtons: [UIButton]!
    @IBOutlet weak var movieNameSearch: UITextField!
    @IBOutlet weak var listViewContainer: UIView!
    @IBOutlet weak var resultsAmount: UILabel!
    @IBOutlet weak var currentPage: UILabel!
    @IBOutlet weak var currentList: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.movieNameSearch.delegate = self
        let movieFacade = MovieFacade()
        self.presenter = ListMoviePresenter(view: self as ListMoviesView, service: movieFacade)
        self.setListType()
        
    }
    
    override func viewLayoutMarginsDidChange() {
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
        customList.reloadAllData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.presenter.searchMoviesByName(name : movieNameSearch.text!)
        return true;
    }
    
    @IBAction func SearchMovies(_ sender: Any) {
        self.presenter.searchMoviesByName(name : movieNameSearch.text!)
    }

    @IBAction func searchMoviesList(_ sender: UIButton) {
        for button in listsButtons {
            if button == sender {
                button.backgroundColor = #colorLiteral(red: 0.792909264, green: 0.4599874668, blue: 0.01020182102, alpha: 1)
            } else {
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        
        self.presenter.searchMoviesList(listToSearch: (sender.titleLabel?.text)!)
    }
    
    @IBAction func changeListType(_ sender: Any) {
        self.presenter.changeListKind()
    }
    
    fileprivate func setListType() {
        
        for view in self.listViewContainer.subviews {
            view.removeFromSuperview()
        }
        
        let customListFrame = CGRect(x: 0, y: 0, width: self.listViewContainer.frame.width, height: self.listViewContainer.frame.height)
        
        if presenter.listKind == EnumDataTypes.ListKind.table {
            customList = CustomListTableView(frame: customListFrame)
            self.changeListButton.title = "⌗"
        } else {
            customList = CustomListCollectionView(frame: customListFrame)
            self.changeListButton.title = "⌸"
        }
        self.listViewContainer.addSubview(customList as! UIView)
        
        (customList as! UIView).translatesAutoresizingMaskIntoConstraints = false
        
        (customList as! UIView).topAnchor.constraint(equalTo: self.listViewContainer.topAnchor, constant: 0).isActive = true
        (customList as! UIView).bottomAnchor.constraint(equalTo: self.listViewContainer.bottomAnchor, constant: 0).isActive = true
        (customList as! UIView).leftAnchor.constraint(equalTo: self.listViewContainer.leftAnchor, constant: 0).isActive = true
        (customList as! UIView).rightAnchor.constraint(equalTo: self.listViewContainer.rightAnchor, constant: 0).isActive = true
        
        self.customList.customDelegate = self
        
        self.listViewContainer.autoresizesSubviews = true
        
        self.presenter.searchMoviesList(listToSearch: "Now")
    }
    
}


extension MovieViewController : CustomListDelegate {
    
    func numberOfCells() -> Int {
        let numberOfMovies = self.presenter.movies?.movies?.count
        return numberOfMovies ?? 0
    }
    
    func configureCell(cell: CustomListCell, index: Int) {
        let movieCell = self.presenter.movies?.movies![index]
        cell.movieTitle.text = movieCell?.title
        cell.movieDescription.text = movieCell?.overview
        
        let posterID = (movieCell?.posterPath)!
        let imageURL = posterID.isEmpty ? nil : URL(string: ApplicationConstants.theMovieDBAPIMoviePosterURL + posterID)
        if (imageURL != nil) {
          cell.movieImage.af_setImage(withURL: imageURL!)
        }  else {
            cell.movieImage.image = UIImage(named: "DefaultImage")
        }
    }
    func didSelectRow(atIndex index: Int) {
        let movieCell = self.presenter.movies?.movies![index]
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as! MovieDetailViewController
        detailController.movie = movieCell
        present(detailController, animated: true)
    }
}

extension MovieViewController : ListMoviesView {
    
    func onUpdateMovies() {
        let movies = self.presenter.movies
        self.resultsAmount.text = "\(String(describing: (movies?.totalResults)!)) results"
        self.currentPage.text = "Page \(presenter.page) of \(String(describing: (movies?.totalPages)!))"
        self.currentList.text = self.presenter.currentList
        self.customList.reloadAllData()
    }
    
    func onChangeListKind() {
        self.setListType()
    }
    
}

