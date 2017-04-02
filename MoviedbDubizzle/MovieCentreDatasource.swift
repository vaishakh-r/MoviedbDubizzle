//
//  MovieCentreDatasource.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import UIKit

protocol MovieCentreDatasourceDelegate {
    func reloadData()
    func loadMovieDetails(movie: MovieModel)  
}

class MovieCentreDatasource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
 
    
    var delegate: MovieCentreDatasourceDelegate?
    var lastContentOffset: CGFloat = 0
    var movieList:[MovieModel] = []

    init(delegate: MovieCentreDatasourceDelegate?) {
        self.delegate = delegate
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cellIdentifier = "MovieCollectionViewCell"
          let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCollectionViewCell
          let movieModel = movieList[indexPath.row]
          movieCell.reloadEntity(entity: movieModel)
          return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let movieModel = movieList[indexPath.row]
          delegate?.loadMovieDetails(movie: movieModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if self.lastContentOffset < offsetY && offsetY > contentHeight - scrollView.frame.size.height {
            delegate?.reloadData()
        }
        lastContentOffset = offsetY
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: GlobalConstants.DeviceWidth, height: 140)
    }
    
    
}
