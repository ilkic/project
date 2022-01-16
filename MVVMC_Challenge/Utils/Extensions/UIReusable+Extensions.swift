//
//  UITableViewCell+Extensions.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import UIKit

extension UITableViewCell {
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UICollectionViewCell {
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
