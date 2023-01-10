//
//  Constants.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit


enum Endpoints {
    
    static let deneme = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=DEMO_KEY"
    
    static let baseURL      = "https://api.nasa.gov/mars-photos/api/v1"
    static let curiosity    = "/rovers/curiosity/"
    static let opportunity  = "/rovers/opportunity/"
    static let spirit       = "/rovers/spirit/"
    static let sol          = "photos?sol=1000&"
    static let earthDate    = "photos?earth_date="
    static let page         = "&page="
    static let cam          = "&camera="
    static let apiKey       = "&api_key=oQLbt0FhONvqyi8yR06hqYnBf0aaNwtwaYLLOgEd"
}


enum Images {
    
    static let curiosityLogo = UIImage(systemName: "camera.metering.multispot")
    static let opportunityLogo = UIImage(systemName: "camera.metering.matrix")
    static let spiritLogo = UIImage(systemName: "camera.metering.partial")
    static let favorite = UIImage(systemName: "star.fill")
    static let nonFavorite = UIImage(systemName: "star")
    
}

