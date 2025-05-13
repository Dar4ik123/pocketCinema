//
//  NetworkError.swift
//  Pocket Cinema
//
//  Created by Айдар on 12.05.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError(DecodingError)
    case noData
    case invalidResponse
    case parsingError
    case requestError(Error)
    
}
