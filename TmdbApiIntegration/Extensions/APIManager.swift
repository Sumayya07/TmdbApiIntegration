//
//  APIManager.swift
//  TmdbApiIntegration
//
//  Created by Sumayya Siddiqui on 28/03/23.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let detailsApi = "https://api.themoviedb.org/3/movie/725201?api_key=e8db82ed17e9ab064d2bd8cad9b06a94&language=en-US"
    
    let titlesApi = "https://api.themoviedb.org/3/movie/725201/alternative_titles?api_key=e8db82ed17e9ab064d2bd8cad9b06a94"
    
    
    
    
    func load<T: Decodable>(urlRequest: URLRequest, type:T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("json >>>>", json)
                
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch (let error) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
}