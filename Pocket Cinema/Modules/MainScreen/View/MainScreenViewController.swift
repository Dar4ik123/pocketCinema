//
//  ViewController.swift
//  Pocket Cinema
//
//  Created by Айдар on 30.04.2025.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
    
    private var viewModel = MainScreenViewModel(cells: [])
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewModel.getMockData(count: 10)
        setupFlowLayout()
        fetchMovie()
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
 
  private func fetchMovie() {
        let target: ApiTarget = .films
        NetworkManager.shared.fetch(target) { result in
            switch result {
            case .success(let counties):
                print(counties)
            case .failure(let error):
                print(error)
            }
            
        }
    }

