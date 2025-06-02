import Foundation
import UIKit

final class MainScreenPresenter {
    
    //MARK: - Dependencies
    weak var view: MainScreenViewControllerProtocol?
    private let networkManager: NetworkManager
    private var model: MainScreenFlowModel
    
    init(
        networkManager: NetworkManager,
        model: MainScreenFlowModel
    ) {
        self.networkManager = networkManager
        self.model = model
    }
}

//MARK: - MVPPresenterProtocol
extension MainScreenPresenter: MainScreenPresenterProtocol {
    func getNetworkManager() -> any NetworkManager {
        return networkManager
    }
    
    
    func viewDidLoad() {
        fetchMovie(page: model.page)
    }
    
    func didChangePage(isNext: Bool) {
        if isNext {
            model.page += 1
            
        } else {
            model.page = max(1, model.page - 1)
        }
        fetchMovie(page: model.page)
    }
}

extension MainScreenPresenter {
    
    private func fetchMovie(page: Int) {
        model.state = .loading
        updateView()
        
        let target: ApiTarget = .films(page: page)
        networkManager.fetch(target) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let movies):
                    self.model.movieResponse = movies
                    self.model.state = .data
                case .failure:
                    self.model.state = .error
                }
                self.updateView()
            }
        }
    }
    
    func makeViewModel() -> MainScreenViewModel {
        var cells: [MainScreenViewModel.MainScreenCellConfiguration] = []
        model.movieResponse?.search.forEach {
            let poster = $0.poster ?? ""
            cells.append(.init(title: $0.title, year: $0.year, poster: poster))
            
        }
        return MainScreenViewModel(cells: cells, state: model.state)
    }
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let viewModel = self?.makeViewModel() else { return }
            self?.view?.configure(viewModel: viewModel)
        }
    }
    
}








