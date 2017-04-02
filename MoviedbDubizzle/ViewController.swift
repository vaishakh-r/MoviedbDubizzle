//
//  ViewController.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, MovieCentreDatasourceDelegate, SortPopVCDelegate {

    var movieList: [MovieModel]?
    @IBOutlet weak var collectionView: UICollectionView!
    private var flowLayout = UICollectionViewFlowLayout()
    private var dataSource: MovieCentreDatasource!
    @IBOutlet weak var footerLabel: UILabel!
    var isMovieListLoading: Bool = false // To prevent repetitve calls during the infiniet scrolling
    
    var minYear: Int!
    var maxYear: Int!
    var currentPaginYear: Int!
    var isYearListDescending: Bool = true
    var page: Int = 1
    let utils = CommonUtils()
    @IBOutlet weak var fromYearLabel: UILabel!
    @IBOutlet weak var toYearLabel: UILabel!
    @IBOutlet weak var sortDescendingLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie List"
        setupUI()
        setupCollectionView()
        setUpDateInfo()
        currentPaginYear = maxYear
        loadNewMovieList()
    }
    
    func setupTestUIInfo() {
        fromYearLabel.accessibilityIdentifier = "maxYearLabel"
        toYearLabel.accessibilityIdentifier = "minYearLabel"

    }
    
    func setUpDateInfo() {
        maxYear = utils.getCurrentYear()
        minYear = utils.getCurrentYear()-1
        setYearLabel()
    }
    
    func setYearLabel() {
        fromYearLabel.text = "\(minYear!)"
        toYearLabel.text = "\(maxYear!)"

    }
    
    func setupUI() {
        self.view.setNeedsLayout()
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    func setupCollectionView() {
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        if #available(iOS 9, *) {
            flowLayout.sectionHeadersPinToVisibleBounds = true
        }
        dataSource = MovieCentreDatasource.init(delegate: self)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.alwaysBounceVertical = true
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.collectionViewLayout = flowLayout
    }

    func loadNewMovieList() {
        
        if !isMovieListLoading {
            isMovieListLoading = true
            NetworkManager.sharedInstance.discoverMoviesForYear(page: page, year: currentPaginYear) { (responseMovieList, error) in
                self.activityIndicator.stopAnimating()
                if error != nil {
                    print("Load Movie Error : \(error?.localizedDescription)")
                    return
                }
                guard let movieList = responseMovieList, movieList.count > 0 else {
                    print("No more Data to add")
                    return
                }
                if self.dataSource.movieList.count > 0 {
                    self.dataSource.movieList.append(contentsOf: movieList)
                } else {
                    self.dataSource.movieList = movieList
                }

                self.page += 1
                self.checkYearRange(movieList: movieList)
                self.collectionView.dataSource = self.dataSource
                self.collectionView.delegate = self.dataSource
                self.isMovieListLoading = false
                self.collectionView.reloadData()
            }
        }
        
    }
    
    func checkYearRange(movieList: [MovieModel]) {
        if movieList.count < 20 {
            if isYearListDescending {
                if currentPaginYear > minYear {
                    currentPaginYear = currentPaginYear - 1
                    self.page = 1
                }
            } else {
                if currentPaginYear < maxYear {
                    currentPaginYear = currentPaginYear + 1
                    self.page = 1
                }
            }
        }
        self.footerLabel.text = "Movies Loaded: \(self.dataSource.movieList.count) "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: MovieDataSourceDeleagte
    func reloadData() {
        self.activityIndicator.startAnimating()
        loadNewMovieList()
    }
    
    func loadMovieDetails(movie: MovieModel)  {
        let movidDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "moviedetailsVC") as! MoviedetailsViewController
        movidDetailsViewController.movideModel = movie
        self.navigationController?.pushViewController(movidDetailsViewController, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popVC" {
            let destVc = segue.destination as! SortPopViewController
            destVc.minYear = minYear
            destVc.maxYear = maxYear
            destVc.isSortDescending = isYearListDescending
            destVc.sortVCDelegate = self
        }
    }
    
    // MARK: SORTVC DELEGATE
    func reloadWithData(minYear: Int, maxYear: Int, isSortDescending: Bool) {
        self.minYear = minYear
        self.maxYear = maxYear
        setYearLabel()
        self.isYearListDescending = isSortDescending
        resetInfo()
        self.activityIndicator.startAnimating()
        loadNewMovieList()
    }
    
    func resetInfo() {
        self.dataSource.movieList = []
        collectionView.reloadData()
        self.page = 1
        if isYearListDescending {
            currentPaginYear = maxYear
            sortDescendingLabel.text = "Newest"
        } else {
            currentPaginYear = minYear
            sortDescendingLabel.text = "Oldest"

        }
    }
    
}

