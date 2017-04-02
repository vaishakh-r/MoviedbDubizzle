//
//  GlobalConstants.swift
//  MoviedbDubizzle
//
//  Created by Vaishakh on 4/2/17.
//  Copyright © 2017 Vaishakh. All rights reserved.
//

import Foundation
import UIKit

struct GlobalConstants {
    
    static let movieDbApiKey = "344174ddf96e55efc838ccdd44bc6e79"
    static let baseUrl = "https://api.themoviedb.org/3"
    static let DeviceWidth = UIScreen.main.bounds.size.width
    static let imageBaseUrl = "http://image.tmdb.org/t/p"
}

enum ImageType: String{

    case W500 = "w500"
    case W300 = "w300"
    case W185 = "w185"
    
}

