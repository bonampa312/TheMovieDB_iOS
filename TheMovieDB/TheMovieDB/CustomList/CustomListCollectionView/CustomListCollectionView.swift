//
//  CustomListCollectionView.swift
//  TheMovieDB
//
//  Created by Santiago Romero Restrepo on 3/16/18.
//  Copyright © 2018 Globant. All rights reserved.
//

import UIKit

class CustomListCollectionView: UICollectionView, CustomList {

    //MARK: Properties
    weak var customDelegate : CustomListDelegate?
    
    fileprivate let cellIdentifier = "CustomListCollectionViewCell"
    fileprivate let cellsPerRow = 3
    fileprivate let cellHeight: CGFloat = 200
    fileprivate let bottomSpaceBetweenCells: CGFloat = 10
    fileprivate let leftPadding: CGFloat = 10
    fileprivate let rightPadding: CGFloat = 10
    fileprivate let topPadding: CGFloat = 10
    fileprivate let middleSpaceBetweenCells: CGFloat = 10
    
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func reloadAllData(){
        reloadData()
    }
}

private extension CustomListCollectionView {
    func configure() {
        self.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        dataSource = self
        delegate = self
        configureFlowLayout()
    }
    
    func configureFlowLayout() {
        let viewFlowLayout = UICollectionViewFlowLayout()
        
        viewFlowLayout.minimumInteritemSpacing = middleSpaceBetweenCells
        viewFlowLayout.minimumLineSpacing = bottomSpaceBetweenCells
        viewFlowLayout.sectionInset = UIEdgeInsetsMake(topPadding, leftPadding, 0, rightPadding)
        
        backgroundColor = UIColor.clear
        collectionViewLayout = viewFlowLayout
    }
}

extension CustomListCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.customDelegate?.numberOfCells() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath : IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomListCollectionViewCell
        
        customDelegate?.configureCell(cell: cell as CustomListCell, index: indexPath.row)
        return cell
    }
}

extension CustomListCollectionView : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        let blankSpaces = leftPadding + middleSpaceBetweenCells
        let width = collectionWidth / CGFloat(cellsPerRow) - blankSpaces
        
        return CGSize(width: width, height: cellHeight)
    }
}


