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

class SearchMovieController: UIViewController, UITextFieldDelegate {
    
    fileprivate var movies : MovieList?
    fileprivate var customList : CustomList!
    private var listKind : ListKind = ListKind.table

    
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
        self.setListType()
        
    }
    
    override func viewLayoutMarginsDidChange() {
        self.view.setNeedsDisplay()
        self.view.setNeedsLayout()
        customList.reloadAllData()
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
        let page = 1
        MovieFacade.searchMoviesBy(name: movieNameSearch.text!, page: page, completion: {[weak self] moviesByName in
            if let moviesList = moviesByName {
                self?.movies = moviesList
                self?.resultsAmount.text = String(moviesList.totalResults!) + " results"
                self?.currentPage.text = "Page \(page) of \(String(moviesList.totalPages!))"
                self?.customList.reloadAllData()
            } else {
                print("No movies to show, error on request")
            }
        })
    }
    
    func searchMoviesList(listToSearch: String) {
        let page = 1
        switch (listToSearch) {
            case "Now":
                self.currentList.text = "Now Playing"
            case "Popular":
                self.currentList.text = "Popular Movies"
            case "Top":
                self.currentList.text = "Top Rated Movies"
            case "Soon":
                self.currentList.text = "Coming Soon"
            default:
                self.currentList.text = ""
        }
        MovieFacade.searchMoviesBy(listTitle: listToSearch, page: page, completion: { [weak self] moviesByList in
            if let moviesList = moviesByList {
                self?.movies = moviesList
                self?.resultsAmount.text = String(moviesList.totalResults!) + " results"
                self?.currentPage.text = "Page \(page) of \(String(moviesList.totalPages!))"
                self?.customList.reloadAllData()
            } else {
                print("No movies to show, error on request")
            }
        })
    }

    @IBAction func searchMoviesList(_ sender: UIButton) {
        for button in listsButtons {
            if button == sender {
                button.backgroundColor = #colorLiteral(red: 0.792909264, green: 0.4599874668, blue: 0.01020182102, alpha: 1)
            } else {
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        self.searchMoviesList(listToSearch: (sender.titleLabel?.text)!)
    }
    
    @IBAction func changeListType(_ sender: Any) {
        listKind = (listKind == ListKind.table) ? .collection : .table
        self.setListType()
    }
    
    private func setListType() {
        
        for view in self.listViewContainer.subviews {
            view.removeFromSuperview()
        }
        
        let customListFrame = CGRect(x: 0, y: 0, width: self.listViewContainer.frame.width, height: self.listViewContainer.frame.height)
        
        if listKind == ListKind.table {
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
        
        self.searchMoviesList(listToSearch: "Now")
    }
    
}


extension SearchMovieController : CustomListDelegate {
    
    func numberOfCells() -> Int {
        let numberOfMovies = self.movies?.movies!.count
        return numberOfMovies ?? 0
    }
    
    func configureCell(cell: CustomListCell, index: Int) {
        cell.movieTitle.text = self.movies?.movies![index].title
        cell.movieDescription.text = self.movies?.movies![index].overview
        
        let posterID = (self.movies?.movies![index].posterPath)!
        let imageURL = posterID.isEmpty ? nil : URL(string: ApplicationConstants.theMovieDBAPIMoviePosterURL + posterID)
        if (imageURL != nil) {
          cell.movieImage.af_setImage(withURL: imageURL!)
        }  else {
            cell.movieImage.image = UIImage(named: "DefaultImage")
        }
    }
    func didSelectRow(atIndex index: Int) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as! MovieDetailViewController
        detailController.movie = movies?.movies![index]
        present(detailController, animated: true)
    }
}

extension SearchMovieController {
    
    fileprivate enum ListKind {
        case table, collection
    }
}
