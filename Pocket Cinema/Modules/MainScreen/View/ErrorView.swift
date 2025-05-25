import UIKit

let myView: UIView = {
    let view = UIView()
    return view
}()

func showErrorView(on oneErrorView: UIView) {
    
    oneErrorView.subviews.forEach {
            if $0.accessibilityIdentifier == "errorContainer" {
                $0.removeFromSuperview()
            }
        }
    
    let errorContainer = UIView()
    errorContainer.accessibilityIdentifier = "errorContainer"
    errorContainer.translatesAutoresizingMaskIntoConstraints = false
    oneErrorView.addSubview(errorContainer)
    
    let errorImageView = UIImageView()
    errorImageView.backgroundColor = .black
    errorImageView.image = UIImage(systemName: "wifi")
    errorImageView.contentMode = .scaleAspectFit
    errorImageView.translatesAutoresizingMaskIntoConstraints = false
    
    let errorLabel = UILabel()
    errorLabel.textColor = .white
    errorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    errorLabel.textAlignment = .center
    errorLabel.text = "Ошибка"
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    
    errorContainer.addSubview(errorImageView)
    errorContainer.addSubview(errorLabel)
    
    NSLayoutConstraint.activate([
        
        errorContainer.centerXAnchor.constraint(equalTo: oneErrorView.centerXAnchor),
        errorContainer.centerYAnchor.constraint(equalTo: oneErrorView.centerYAnchor),
        errorContainer.widthAnchor.constraint(equalTo: oneErrorView.widthAnchor, multiplier: 0.8),
        
        
        errorImageView.topAnchor.constraint(equalTo: errorContainer.topAnchor, constant: 16),
        errorImageView.centerXAnchor.constraint(equalTo: errorContainer.centerXAnchor),
        errorImageView.heightAnchor.constraint(equalToConstant: 80),
        
        
        errorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 8),
        errorLabel.leadingAnchor.constraint(equalTo: errorContainer.leadingAnchor, constant: 8),
        errorLabel.trailingAnchor.constraint(equalTo: errorContainer.trailingAnchor, constant: -8),
        errorLabel.bottomAnchor.constraint(equalTo: errorContainer.bottomAnchor, constant: -16)
    ])
    
    
    errorContainer.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    errorContainer.layer.cornerRadius = 12
    errorContainer.clipsToBounds = true
    
    
    errorContainer.alpha = 0
    UIView.animate(withDuration: 0.3) {
        errorContainer.alpha = 1
    }
    
    }

