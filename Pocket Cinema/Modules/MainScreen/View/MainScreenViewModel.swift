//
//  MainScreenViewModel.swift
//  Pocket Cinema
//
//  Created by Айдар on 30.04.2025.
//

import Foundation

struct MainScreenViewModel {
    var cells: [MainScreenCellConfiguration]
    let state: State
}

extension MainScreenViewModel {
    struct MainScreenCellConfiguration {
        let title: String
        let year: String
        let poster: String?
    }
}

extension MainScreenViewModel {
    enum State {
        case data
        case loading
        case error
    }
}
