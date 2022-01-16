//
//  UIViewController+ActivityIndicator.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import UIKit

extension UIViewController {

    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tintColor = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)

        return activityIndicator
    }
}


