//
//  MVPComposter.swift
//  Pocket Cinema
//
//  Created by Айдар on 16.05.2025.
//

import UIKit

final class MainScreenComposter: MainScreenComposterProtocol {
    
    private func makePresenter() -> MainScreenPresenterProtocol {
        let networkManager = NetworkManagerImpl()
        let model = MainScreenFlowModel()
        return MainScreenPresenter(networkManager: networkManager, model: model)
        
    }
    
    func make() -> UIViewController {
        let networkManager = NetworkManagerImpl()
        let model = MainScreenFlowModel()
        let presenter = MainScreenPresenter(networkManager: networkManager, model: model)
        let viewController = MainScreenViewController(presenter: presenter)
        presenter.view = viewController 
        
        return viewController
    }
                
            }
           
        
    
    

