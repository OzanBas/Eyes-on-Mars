//
//  EMError.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import Foundation


enum EMError: String, Error {
    
    case NoInternetConnection   = "No Internet Connection: Can not send request."
    case badEndpoint            = "Bad Endpoint: Can not convert to an URL."
    case badResponse            = "Bad Response: Unexpected server response."
    case parsingError           = "Parsing Error: Can not parse JSON. Server response might be changed or something is broken."
    case dataError              = "Invalid Data: Server response is unusable."
    
    case savingError            = "Saving Error: Can't add this coin to your favorites list."
    case retrievingFavorites    = "Can't get your favorite coins."
    case addingAlert            = "Added to Favorites"
    case removingAlert          = "Removed from Favorites"
}
