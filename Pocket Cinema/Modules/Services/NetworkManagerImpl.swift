//
//  NetworkManager.swift
//  Pocket Cinema
//
//  Created by Айдар on 12.05.2025.
//

import UIKit

protocol NetworkManager {
    func fetch(_ target: ApiTarget, completion: @escaping(Result<MovieResponse, NetworkError>) -> Void)
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void)
}
final class NetworkManagerImpl: NetworkManager {
    
    func fetch(_ target: ApiTarget, completion: @escaping(Result<MovieResponse, NetworkError>) -> Void) {
        request(target, completion: completion)
    }
    
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    private func request<T: Decodable>(_ target: ApiTarget, completion: @escaping(Result<T, NetworkError>) -> Void) {
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



