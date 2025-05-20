//
//  MainScreenContract.swift
//  Pocket Cinema
//
//  Created by Айдар on 16.05.2025.
//

import UIKit

protocol MainScreenComposterProtocol: AnyObject {
    func make() -> UIViewController
}

protocol MainScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didChangePage(isNext: Bool)
}

protocol MainScreenViewControllerProtocol: AnyObject {
    func configure(viewModel: MainScreenViewModel)
}


