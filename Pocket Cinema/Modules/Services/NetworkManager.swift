//
//  NetworkManager.swift
//  Pocket Cinema
//
//  Created by Айдар on 12.05.2025.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetch(_ target: ApiTarget, completion: @escaping(Result<MovieResponse, NetworkError>) -> Void) {
        request(target, completion: completion)
    }
    
    private func request<T: Codable>(_ target: ApiTarget, completion: @escaping(Result<T, NetworkError>) -> Void) {
                guard let url = URL(string: target.baseUrl + target.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.requestError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let decodingError as DecodingError {
                completion(.failure(.decodingError(decodingError)))
            } catch {
                completion(.failure(.parsingError))
            }
        }.resume()
    }
    
}


