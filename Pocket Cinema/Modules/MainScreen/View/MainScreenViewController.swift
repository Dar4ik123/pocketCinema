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
    private let buttonBack = UIButton()
    private let buttonNext = UIButton()
    
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
        
        buttonBack.setTitle("Back", for: .normal)
        buttonBack.backgroundColor = .systemBlue
        buttonBack.layer.cornerRadius = 8
        
        buttonNext.setTitle("Next", for: .normal)
        buttonNext.backgroundColor = .systemBlue
        buttonNext.layer.cornerRadius = 8
        
        let buttonStackView = UIStackView(arrangedSubviews: [buttonBack, buttonNext])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        view.addSubview(collectionView)
        view.addSubview(buttonStackView)
        
        buttonBack.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        buttonNext.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        
        collectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).inset(16)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
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
    
    @objc private func didTapBack() {
        presenter.didChangePage(isNext: false)
    }

    @objc private func didTapNext() {
        presenter.didChangePage(isNext: true)
    }
    
}

