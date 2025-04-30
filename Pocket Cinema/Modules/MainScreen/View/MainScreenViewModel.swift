//
//  MainScreenViewModel.swift
//  Pocket Cinema
//
//  Created by Айдар on 30.04.2025.
//

import UIKit

struct MainScreenViewModel {
    let cells: [MainScreenCellConfiguration]
}

extension MainScreenViewModel {
    struct MainScreenCellConfiguration {
        let title: String
        let year: String
        let poster: UIImage
    }
}
