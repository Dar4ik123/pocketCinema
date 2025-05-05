//
//  MainScreenViewModel.swift
//  Pocket Cinema
//
//  Created by Айдар on 30.04.2025.
//

import UIKit

struct MainScreenViewModel {
    var cells: [MainScreenCellConfiguration]
}

extension MainScreenViewModel {
    struct MainScreenCellConfiguration {
        let title: String
        let year: String
        let poster: UIImage?
    }
}

extension MainScreenViewModel {
    func getMockData(count: Int) -> MainScreenViewModel {
        var cells: [MainScreenCellConfiguration] = []
        for count in 0..<count {
            cells.append(MainScreenCellConfiguration(
                title: "Title \(count)",
                year: "200\(count)",
                poster: UIImage(named: "testImage")
            ))
        }
        return MainScreenViewModel(cells: cells)
    }
}
