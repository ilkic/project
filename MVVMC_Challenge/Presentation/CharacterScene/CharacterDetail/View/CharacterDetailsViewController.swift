//
//  CharacterDetailViewController.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa
import RxSwiftExt

class CharacterDetailsViewController: BaseViewController, StoryboardInstantiable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var comicsActivityIndicator: UIActivityIndicatorView!
    
    private var viewModel: CharacterDetailsViewModel!
        
    
    static func create(with viewModel: CharacterDetailsViewModel) -> CharacterDetailsViewController {
        let view = CharacterDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRx()
    }
    
    func initView() {
        title = "Character Detail"
        comicsActivityIndicator.hidesWhenStopped = true
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 200)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = .leastNonzeroMagnitude
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(CharacterDetailsComicCollectionViewCell.nib, forCellWithReuseIdentifier: CharacterDetailsComicCollectionViewCell.reuseIdentifier)
    }
    
    func setupRx() {
        assert(viewModel != nil)
        
        let input = CharacterDetailsViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        titleLabel.text = output.title
        descriptionLabel.text = output.description
        coverImageView.sd_setImage(with: URL(string: output.imageUrl))
        
        output.fetching
        .drive(comicsActivityIndicator.rx.isAnimating)
        .disposed(by: disposeBag)
        
        output.comics.drive(
            collectionView.rx.items(
                cellIdentifier: CharacterDetailsComicCollectionViewCell.reuseIdentifier,
                cellType: CharacterDetailsComicCollectionViewCell.self)) { _, viewModel, cell in
                    cell.bind(viewModel)
                }.disposed(by: disposeBag)
        
        output.error.drive(onNext: { (error) in
            debugPrint("error \(error)")
        }).disposed(by: disposeBag)
        
        
     
    }
    
    
    
    

}
