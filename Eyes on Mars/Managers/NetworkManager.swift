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
    
    
    func request<T:Decodable>(for rover: String, page: Int, completion: @escaping (Result<T, EMError> ) -> Void) {
        
        let urlString = baseURL + rover + Endpoints.sol + Endpoints.page + String(page) + Endpoints.apiKey
        
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
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
    
    
}
