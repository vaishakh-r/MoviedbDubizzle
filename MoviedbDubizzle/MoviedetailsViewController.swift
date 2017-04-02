//
//  MoviedetailsViewController.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import UIKit
import SDWebImage

class MoviedetailsViewController: UIViewController {

    var movideModel:MovieModel!
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overViewTextView: UITextView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    
    let utils = CommonUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movideModel.movieId!)
        displayMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        overViewTextView.isScrollEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        overViewTextView.isScrollEnabled = true
        overViewTextView.showsVerticalScrollIndicator = true
    }
    
    func displayMovieData() {
        movieTitleLabel.text = movideModel.title!
        overViewTextView.text = movideModel.overview!
        
        if let imagePath = movideModel.posterPath {
            let imageUrl = utils.getImageUrl(posterPath: imagePath, imageType: .W300)
                 movieImageView.sd_setImage(with: URL.init(string: imageUrl), placeholderImage: UIImage.init(named: "moviebg"))
        }
        
        if let releasDate = movideModel.releaseDate {
            releaseDateLabel.text = "Release : \(releasDate)"
        }
        
        if movideModel.genreId.count > 0 {
            
            let strArray = movideModel.genreId.map{
                self.utils.getGenre(genreId: ($0))
                }.joined(separator: ", ")
            
            genreLabel.text = "Genre: \(strArray)"
        }
        
        if let vote = movideModel.voteCount {
            voteLabel.text = "Vote Count : \(vote)"
        }
        
        if let voteAvg = movideModel.voteAverage {
            averageRatingLabel.text = "Average Rating : \(voteAvg)"
        }
    }
}
