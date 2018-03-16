//
//  UITableViewList.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class CustomListTableView: UITableView, UIList {
    
    var delegate: CustomListDelegate?
    
    weak var listDelegate : CustomListDelegate?
    fileprivate let rowHeight = 90
    fileprivate let cellIdentifier = "ListTableCell"
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func reloadAllData() {
        self.reloadData()
    }
}

extension CustomListTableView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDelegate?.numberOfCells() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! CustomListCell
        
        listDelegate?.configureCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

private extension CustomListTableView {
    func configure() {
        register(CustomListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        dataSource = self
    }
}


