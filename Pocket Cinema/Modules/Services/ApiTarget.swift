//
//  ApiTarget.swift
//  Pocket Cinema
//
//  Created by Айдар on 12.05.2025.
//

import Foundation

protocol ApiTargetType {
    var baseUrl: String { get }
    var path: String { get }
}

enum ApiTarget: ApiTargetType {
    case films
    
    var baseUrl: String { "https://www.omdbapi.com/" }
    var path: String {
        switch self {
        case .films:
            return "?s=movie&type=movie&page=1&apikey=a08d04c5"
        }
    }
}
