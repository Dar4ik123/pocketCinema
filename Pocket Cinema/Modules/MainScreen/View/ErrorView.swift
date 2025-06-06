import UIKit

final class ErrorView: UIView {
    private let errorImage = UIImageView()
    private let errorLabel = UILabel()
    private let refreshButton = UIButton()
    var didTapRefreshButton: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ErrorView {
    func setupView() {
        backgroundColor = .white
        
        errorImage.image = UIImage(systemName: "wifi")
        errorImage.contentMode = .scaleAspectFit
        errorImage.tintColor = .systemGray
        
        errorLabel.text = "Нет соединения с интернетом"
        errorLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        errorLabel.textColor = .darkGray
        errorLabel.textAlignment = .center
        
        refreshButton.setTitle("Обновить", for: .normal)
        refreshButton.backgroundColor = .systemGray4
        refreshButton.layer.cornerRadius = 9
        refreshButton.layer.borderWidth = 1
        refreshButton.layer.borderColor = UIColor.systemGray6.cgColor
        refreshButton.setTitleColor(.systemBlue, for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonDidTap), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [errorImage, errorLabel, refreshButton])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(40)
        }
        
        errorImage.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
    }
    
    @objc func refreshButtonDidTap() {
        didTapRefreshButton?()
    }
}
