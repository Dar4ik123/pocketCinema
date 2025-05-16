//
//  ViewController.swift
//  Pocket Cinema
//
//  Created by Айдар on 30.04.2025.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
    
    private let presenter: MainScreenPresenterProtocol
    private var viewModel = MainScreenViewModel(cells: [])
    private var collectionView: UICollectionView!
    
    init(presenter: MainScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowLayout()
        presenter.viewDidLoad()
        
    }
    
    private func setupFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: (view.frame.width - 48) / 2, height: 320)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: MainScreenCollectionViewCell.reuseID)
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
    }
}

extension MainScreenViewController: MainScreenViewControllerProtocol {
    func configure(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        print(viewModel)
        collectionView.reloadData()
    }
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainScreenCollectionViewCell.reuseID,
            for: indexPath
        ) as? MainScreenCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: viewModel.cells[indexPath.row])
        return cell
    }
}
