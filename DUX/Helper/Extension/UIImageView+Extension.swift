//
//  UIImageView+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import UIKit

extension UIImageView {
    func getImageFromURL(_ urlString: String) {
        var indicator: UIActivityIndicatorView? = {
            let view = UIActivityIndicatorView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.startAnimating()
            view.color = .lightGray
            self.addSubview(view)
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
            return view
        }()
        
        GithubAPI.requestManager.requestWithURL(urlString: urlString) { result in
            switch result {
            case .success(let imageData):
                self.image = .init(data: imageData)
                indicator?.removeFromSuperview()
                indicator = nil
            case .failure(_):
                return
            }
        }
    }
}
