//
//  MovieCollectionViewCell.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    let utils = CommonUtils()
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = UIImage.init(named: "movie_default")
    }
    
    func reloadEntity(entity: MovieModel) {
        if let title = entity.title {
            movieTitleLabel.text = title
        }
        if let dateString = entity.releaseDate {
            yearLabel.text = utils.getYearFromDateString(dateString: dateString)
        }
        if let posterPath = entity.posterPath {
            let imageUrlString = utils.getImageUrl(posterPath: posterPath, imageType: ImageType.W185)
            movieImageView.sd_setImage(with: URL.init(string: imageUrlString), placeholderImage: UIImage.init(named: "movie_default"))
        }
        if entity.genreId.count > 0 {
            let strArray = entity.genreId.map{
                self.utils.getGenre(genreId: ($0))
            }.joined(separator: ", ")
            genreLabel.text = strArray
        }
        
    }
    
    // TODO: move to a common UTIL class

}
