//
//  MovieModel.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import Foundation

class MovieModel: NSObject {
    
    var movieId: Int?
    var title: String?
    var overview: String?
    var popularity: Double?
    var releaseDate: String?
    var voteAverage: Int?
    var voteCount: Int?
    var genreId:[Int] = []
    var posterPath: String?
    
    init?(dictionary: NSDictionary?) {
        super.init()
        // This prevents cases in which the array exists but with an garbage value
        guard let dictionary = dictionary else {
            return nil
        }
        self.parseDictionary(dictionary: dictionary)
    }
    
    func parseDictionary(dictionary: NSDictionary) {
        if let moviedId = dictionary["id"] as? Int {
            self.movieId = moviedId
        }
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        if let overview = dictionary["overview"] as? String {
            self.overview = overview
        }
        if let popularity = dictionary["popularity"] as? Double {
            self.popularity = popularity
        }
        if let releaseDate = dictionary["release_date"] as? String {
            self.releaseDate = releaseDate
        }
        if let voteAverage = dictionary["vote_average"] as? Int {
            self.voteAverage = voteAverage
        }
        if let voteCount = dictionary["vote_count"] as? Int {
            self.voteCount = voteCount
        }
        if let genreIds = dictionary["genre_ids"] as? [Int] {
            genreId.append(contentsOf: genreIds)
        }
        if let posterPath = dictionary["poster_path"] as? String {
          self.posterPath = posterPath

        }
    }
}
