//
//  MoviePresenter.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/22/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

protocol ListMoviesView : class {
    func onUpdateMovies()
    func onChangeListKind()
}

final class ListMoviePresenter {
    unowned fileprivate var view : ListMoviesView
    fileprivate var service : MovieFacade
    var listKind = EnumDataTypes.ListKind.table
    var currentList : String?
    var page = 1
    
    var movies : MovieList!
    var listType : String {
        didSet {
            self.searchMoviesList(listToSearch: listType)
        }
    }
    
    init(view: ListMoviesView, service : MovieFacade) {
        self.view = view
        self.service = service
        self.listType = "Now"
    }
    
    func searchMoviesList(listToSearch: String) {
        switch (listToSearch) {
        case "Now":
            currentList = "Now Playing"
        case "Popular":
            currentList = "Popular Movies"
        case "Top":
            currentList = "Top Rated Movies"
        case "Soon":
            currentList = "Coming Soon"
        default:
            currentList = ""
        }
        self.service.searchMoviesBy(listTitle: listToSearch, page: page, completion: { [weak self] moviesByList in
            if let moviesList = moviesByList {
                self?.movies = moviesList
                self?.view.onUpdateMovies()
            } else {
                print("No movies to show, error on request")
            }
        })
    }
    
    func searchMoviesByName(name movieSearchName : String) {
        let page = 1
        currentList = "Searching '\(movieSearchName)'"
        self.service.searchMoviesBy(name: movieSearchName, page: page, completion: {[weak self] moviesByName in
            if let moviesList = moviesByName {
                self?.movies = moviesList
                self?.view.onUpdateMovies()
            } else {
                print("No movies to show, error on request")
            }
        })
    }
    
    func changeListKind() {
        self.listKind = self.listKind == .table ? .collection : .table
        self.view.onChangeListKind()
    }
    
}

