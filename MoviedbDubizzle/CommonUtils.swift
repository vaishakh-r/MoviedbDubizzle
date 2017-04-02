//
//  Utils.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import UIKit
import Foundation

class CommonUtils: NSObject {
    func getImageUrl(posterPath:String, imageType: ImageType) -> String {
        return "\(GlobalConstants.imageBaseUrl)/\(imageType.rawValue)\(posterPath)"
    }
    
    func getYearFromDateString(dateString: String) -> String {
        // Format is YYYY-MM-DD
        let dateComponents = dateString.components(separatedBy: "-")
        return dateComponents[0]
    }
    
    func getCurrentYear() -> Int{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        let currentYear = getYearFromDateString(dateString: dateString)
        return Int(currentYear)!
    }
    
    func getGenre(genreId: Int) -> String {
        
        switch genreId {
        case 28:
            return "Action"
        case 12:
            return "Adventure"
        case 16:
            return "Animation"
        case 35:
            return "Comedy"
        case 80:
            return "Crime"
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
        case 10751:
            return "Family"
        case 18:
            return "Drama"
        case 14:
            return "Fantasy"
        case 36:
            return "History"
        case 27:
            return "Horror"
        case 10402:
            return "Music"
        case 9648:
            return "Mystery"
        case 10749:
            return "Romance"
        case 878:
            return "Science Fiction"
        case 10770:
            return "TV Movie"
        case 53:
            return "Thriller"
        case 10752:
            return "War"
        case 37:
            return "Western"
        default:
            return ""
        }
        
    }
    
}

// Not using SDWebImage since this is a simple application
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print("Image loading error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
