//
//  UITableViewList.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/15/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class CustomListTableView: UITableView, CustomList {
    
    weak var customDelegate: CustomListDelegate?
    
    fileprivate let customRowHeight : CGFloat = 100.0
    fileprivate let cellIdentifier = "CustomListTableViewCell"
    
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
        let numberOfCells = self.customDelegate?.numberOfCells()
        return numberOfCells ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! CustomListTableViewCell
        tableView.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.2117647059, blue: 0.2117647059, alpha: 1)
        tableView.isOpaque = false
        tableView.backgroundView = nil
        cell.backgroundColor = #colorLiteral(red: 0.01005314086, green: 0.01005314086, blue: 0.01005314086, alpha: 0)
        customDelegate?.configureCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return customRowHeight
    }
}

private extension CustomListTableView {
    func configure() {
        register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        dataSource = self
        delegate = self
    }
}

extension CustomListTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customDelegate?.didSelectRow(atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


