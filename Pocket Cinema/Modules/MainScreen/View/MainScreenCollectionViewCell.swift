//
//  MainScreenCollectionViewCell.swift
//  Pocket Cinema
//
//  Created by Айдар on 01.05.2025.
//

import UIKit

final class MainScreenCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "MainScreenCollectionViewCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let yearLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        yearLabel.text = nil
    }
    
    func configure(with configuration: MainScreenViewModel.MainScreenCellConfiguration) {
        titleLabel.text = configuration.title
        yearLabel.text = configuration.year
        imageView.image = configuration.poster
    }
    
    private func setupCell() {
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(yearLabel)
        
        // Настройка imageView
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        // Настройка titleLabel
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 2
        
        // Настройка yearLabel
        yearLabel.textAlignment = .center
        yearLabel.font = .systemFont(ofSize: 12)
        yearLabel.textColor = .secondaryLabel
        
        // Установка констрейнтов
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.bounds.height * 0.75)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
