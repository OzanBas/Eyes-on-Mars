//
//  PersistenceManager.swift
//  Crypto Price Tracker
//
//  Created by Ozan Bas on 18.10.2022.
//

import Foundation


enum PersistenceManager {
    
    static let defaults = UserDefaults.standard
    
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func update(favorite: Photo, completion: @escaping(EMError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                if favorites.contains(where: { $0.id == favorite.id })  {
                        favorites.removeAll { $0.id == favorite.id }
                        let error = saveToFavorites(photo: favorites)
                        guard error == nil else {
                            completion(.savingError)
                            return
                        }
                        return
                    } else {
                        favorites.append(favorite)
                        let error = saveToFavorites(photo: favorites)
                        guard error == nil else {
                            completion(.savingError)
                            return
                        }
                    }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    static func saveToFavorites(photo: [Photo]) -> EMError? {
        
        do {
            let encoder = JSONEncoder()
            let favorite = try encoder.encode(photo)
            defaults.set(favorite, forKey: Keys.favorites)
            return nil
        } catch {
            return .savingError
        }
    }
    
    
    static func retrieveFavorites(completion: @escaping (Result<[Photo], EMError>) -> Void) {
        guard let retrievedData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Photo].self, from: retrievedData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.retrievingFavorites))
        }
    }
}
