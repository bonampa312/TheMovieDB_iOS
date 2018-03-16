//
//  UIListDelegate.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

protocol CustomListDelegate : class {
    
    func numberOfCells() -> Int
    func configureCell(cell: CustomListCell, index: Int)
    
}
