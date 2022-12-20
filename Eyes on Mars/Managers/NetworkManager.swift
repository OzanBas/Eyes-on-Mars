//
//  NetworkManager.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//


import Foundation


class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    private init () {}
    
    let baseURL = Endpoints.baseURL
    let decoder = JSONDecoder()
    
    
    
    func urlCreatorFilter(rover: String, page: Int, earthDate: String) -> String {
        let urlString = baseURL + rover + Endpoints.earthDate + earthDate + Endpoints.page + String(page) + Endpoints.apiKey
        return urlString
    }
    
    
    func urlCreator(rover: String, page: Int, camCodeName: String, earthDate: String) -> String {
        var camEndpoint = "&camera="
        if camCodeName == "" { camEndpoint = "" }
        
        let urlString = baseURL + rover + Endpoints.earthDate + earthDate + Endpoints.page + String(page) + camEndpoint + camCodeName + Endpoints.apiKey
        return urlString
    }
    
    

    func request<T:Decodable>(urlString: String, completion: @escaping (Result<T, EMError> ) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: urlString) else { return }
        print(url)
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.badEndpoint))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let result = try self.decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
    
    
}
