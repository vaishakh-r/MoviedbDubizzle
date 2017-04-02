//
//  NetworkManager.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import Foundation
import  Alamofire

class NetworkManager {

    static let sharedInstance = NetworkManager()
    let utilityQueue = DispatchQueue.global(qos: .utility)

    
    func getMoviesList(completionHandler:@escaping (_ responsObject: [MovieModel]?, _ error: Error?) -> ()) {
        Alamofire.request(Router.getTopRateMovies()).responseJSON { (response:DataResponse<Any>) in

            var movieList: [MovieModel] = []
            switch response.result {
            case .failure(let error):
                print("Webservice Failed")
                completionHandler([], error)
            case .success(let resultDictionary as Dictionary<String, Any>):
                if let movielistDict = resultDictionary["results"] as? NSArray{
                    for movieDict in movielistDict {
                        if let movie = MovieModel.init(dictionary: movieDict as? NSDictionary){
                            movieList.append(movie)
                        }
                    }
                }
                completionHandler(movieList,nil)
            default:
                return
            }
        }
    }
    
    func discoverMoviesForYear(page:Int, year: Int, completionHandler:@escaping (_ responsObject: [MovieModel]?, _ error: Error?) -> ()) {
        
        Alamofire.request(Router.searchMovies(page: page, year: year)).responseJSON(queue: utilityQueue) { (response:DataResponse<Any>) in
            var movieList: [MovieModel] = []
            switch response.result {
            case .failure(let error):
                print("Webservice Failed")
                DispatchQueue.main.async {
                    completionHandler([], error)
                }
            case .success(let resultDictionary as Dictionary<String, Any>):
                if let movielistDict = resultDictionary["results"] as? NSArray{
                    for movieDict in movielistDict {
                        if let movie = MovieModel.init(dictionary: movieDict as? NSDictionary){
                            movieList.append(movie)
                        }
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(movieList,nil)
                }
            default:
                return
            }
        }
    }
  
    
    
}
