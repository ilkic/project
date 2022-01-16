//
//  CharacterDetailsComicCollectionViewCell.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import UIKit
import SDWebImage

class CharacterDetailsComicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ viewModel: CharacterDetailsComicListItemViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: URL(string: viewModel.imageUrl))
    }
}
