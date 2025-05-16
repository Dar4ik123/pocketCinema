//
//  NetworkManager.swift
//  Pocket Cinema
//
//  Created by Айдар on 12.05.2025.
//

import UIKit

protocol NetworkManager {
    func fetch(_ target: ApiTarget, completion: @escaping(Result<MovieResponse, NetworkError>) -> Void)
    func loadImage(url: String) -> UIImage
}

final class NetworkManagerImpl: NetworkManager {
    
    func fetch(_ target: ApiTarget, completion: @escaping(Result<MovieResponse, NetworkError>) -> Void) {
        request(target, completion: completion)
    }
    
    // реализовать func loadImage на вход принимает url в виде String возырвщает uiimage
    func loadImage(url: String) -> UIImage {
        guard let imageUrl = URL(string: url),
              let imageData = try? Data(contentsOf: imageUrl),
              let image = UIImage(data: imageData) else {
    
            return UIImage()
        }
        return image
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


