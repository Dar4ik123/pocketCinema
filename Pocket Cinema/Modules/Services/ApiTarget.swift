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
    case films(page: Int)
    
    var baseUrl: String {
        "https://www.omdbapi.com/"
    }
    
    var path: String {
        switch self {
        case .films(let page):
            return "?s=movie&type=movie&page=\(page)&apikey=a08d04c5"
        }
    }
}
