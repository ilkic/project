//
//  CharacterListItemTableViewCell.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import UIKit
import SDWebImage

class CharacterListItemTableViewCell: UITableViewCell {
    
    static let height = CGFloat(220)

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func bind(_ viewModel: CharacterListItemViewModel) {
        nameLabel.text = viewModel.name
        coverImageView.sd_setImage(with: URL(string: viewModel.imageUrl))
    }
}
