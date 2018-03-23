//
//  EnumDataTypes.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/22/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import Foundation

class EnumDataTypes {

    enum ListKind {
        case table, collection
    }
    
    enum MoviesLists : String {
        case Now, Popular, Top, Soon
    }
    
}
