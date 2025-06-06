//
//  UIImageView + Extension.swift
//  Pocket Cinema
//
//  Created by Айдар on 04.06.2025.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil, showActivityIndicator: Bool = true) {
        self.image = placeholder
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        activityIndicator.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        
        if showActivityIndicator {
            self.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
            } else {
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
            }
        }
    }
    
    func loadImage(from urlString: String, placeholder: UIImage? = nil, showActivityIndicator: Bool = true) {
        guard let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        loadImage(from: url, placeholder: placeholder, showActivityIndicator: showActivityIndicator)
    }
}
