import Foundation

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

    func viewDidLoad() {
        fetchMovie(page: model.page)
    }
    
    func didChangePage(isNext: Bool) {
        
        if isNext {
            model.page += 1
        } else {
            model.page -= 1
        }
        fetchMovie(page: model.page)
        
    }
    
}

extension MainScreenPresenter {
    
    private func fetchMovie(page: Int) {
        let target: ApiTarget = .films(page: page)
        networkManager.fetch(target) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movies):
                model.movieResponse = movies
                let viewModel = makeViewModel()
                DispatchQueue.main.async {
                    self.view?.configure(viewModel: viewModel)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func makeViewModel() -> MainScreenViewModel {
        var cells: [MainScreenViewModel.MainScreenCellConfiguration] = []
        model.movieResponse?.search.forEach {
            let image = networkManager.loadImage(url: $0.poster)
            cells.append(.init(title: $0.title, year: $0.year, poster: image))
        }
        return MainScreenViewModel(cells: cells)
    }
   
}
