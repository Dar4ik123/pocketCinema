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
    private var viewModel = MainScreenViewModel(cells: [], state: .loading)
    
    private var collectionView: UICollectionView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let buttonBack = UIButton()
    private let buttonNext = UIButton()
    private let networkManager: NetworkManager
    init(presenter: MainScreenPresenterProtocol, networkManager: NetworkManager) {
        self.presenter = presenter
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowLayout()
        presenter.viewDidLoad()
        setupActivityIndicator()
        showNoInternetAlert()
        
        
        
       
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
        buttonBack.setTitleColor(.white, for: .normal)
        buttonBack.setTitleColor(.gray, for: .disabled)
        buttonBack.isEnabled = false
        
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
        collectionView.reloadData()
        
        switch viewModel.state {
        case .data:
            activityIndicator.stopAnimating()
            collectionView.isHidden = false
            hideErrorView()
            buttonBack.isEnabled = true
            buttonNext.isEnabled = true
        case .loading:
            activityIndicator.startAnimating()
            collectionView.isHidden = false
            hideErrorView()
            buttonBack.isEnabled = false
            buttonNext.isEnabled = false
        case .error:
            activityIndicator.stopAnimating()
            collectionView.isHidden = true
            showErrorView(on: view)
            buttonBack.isEnabled = false
            buttonNext.isEnabled = true
        }
    }
    
    private func hideErrorView() {
        view.subviews.forEach {
            if $0.accessibilityIdentifier == "errorContainer" {
                $0.removeFromSuperview()
            }
        }
        }
    private func showNoInternetAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "No internet connection",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
        
        cell.configure(with: viewModel.cells[indexPath.row], networkManager: networkManager)
            return cell
    }
    
    @objc private func didTapBack() {
        presenter.didChangePage(isNext: false)
    }

    @objc private func didTapNext() {
        presenter.didChangePage(isNext: true)
    }
    private func setupActivityIndicator() {
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

