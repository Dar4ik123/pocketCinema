//
//  MVPComposter.swift
//  Pocket Cinema
//
//  Created by Айдар on 16.05.2025.
//

import UIKit

final class MainScreenComposter: MainScreenComposterProtocol {
    
    func make() -> UIViewController {
        let networkManager = NetworkManagerImpl()
        let model = MainScreenFlowModel()
        let presenter = MainScreenPresenter(networkManager: networkManager, model: model)
        let viewController = MainScreenViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
