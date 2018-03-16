//
//  CustomListCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/16/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class CustomListCollectionViewCell: UICollectionViewCell, CustomListCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
}
