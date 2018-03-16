//
//  UIListTableViewCell.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class CustomListTableViewCell: UITableViewCell, CustomListCell {
    
    @IBOutlet weak var movieTitle : UILabel!
    @IBOutlet weak var movieImage : UIImageView!
    @IBOutlet weak var movieDescription : UILabel!

}
