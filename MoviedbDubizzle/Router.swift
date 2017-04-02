//
//  Router.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {

    case getTopRateMovies()
    case searchMovies(page:Int, year: Int)
    
    
    var method: HTTPMethod {
        switch self {
        case .getTopRateMovies:
            return .get
        case .searchMovies:
            return .get
        }
        
    }
    
    var path: String {
        switch self {
        case .getTopRateMovies():
            return "/movie/top_rated"
        case .searchMovies:
            return "/discover/movie"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try GlobalConstants.baseUrl.asURL()
        var basicParameters: Parameters = ["api_key":GlobalConstants.movieDbApiKey,"language":"en-US"]
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getTopRateMovies():
            urlRequest = try URLEncoding.default.encode(urlRequest, with: basicParameters)
        case .searchMovies(let page, let year):
            basicParameters.updateValue(page, forKey: "page")
            basicParameters.updateValue(year, forKey: "year")
            basicParameters.updateValue("release_date.desc", forKey: "sort_by")
            basicParameters.updateValue("false", forKey: "include_adult")
            urlRequest = try URLEncoding.default.encode(urlRequest, with: basicParameters)
 
        }
        return urlRequest
    }
}
 
