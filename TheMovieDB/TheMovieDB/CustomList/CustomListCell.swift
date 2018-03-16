//
//  UIListCell.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

protocol CustomListCell : class {

    var movieTitle : UILabel! { get }
    var movieImage : UIImageView! { get }
    var movieDescription : UILabel! { get }

    
}
