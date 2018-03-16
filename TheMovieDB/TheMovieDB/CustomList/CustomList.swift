//
//  UIList.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

protocol CustomList : class {
 
    weak var customDelegate : CustomListDelegate? { get set }

    func reloadAllData()
    
}
