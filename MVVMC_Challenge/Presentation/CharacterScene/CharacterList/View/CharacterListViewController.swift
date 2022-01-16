//
//  ViewController.swift
//  MVVMC_Challenge
//
//  Created by Onur on 15.01.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

class CharacterListViewController: BaseViewController, StoryboardInstantiable {
    @IBOutlet weak var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    
    private lazy var footerIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.bounds.width, height: 50)))
        indicator.startAnimating()
        return indicator
    }()
    
    private var emptyLabel: UILabel!
    
    private var viewModel: CharacterListViewModel!
    
    
    static func create(with viewModel: CharacterListViewModel) -> CharacterListViewController {
        let view = CharacterListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRx()
    }
    
    
    
    private func initView() {
        title = "Characters"
        tableView.register(CharacterListItemTableViewCell.nib, forCellReuseIdentifier: CharacterListItemTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = CharacterListItemTableViewCell.height
        tableView.rowHeight = UITableView.automaticDimension
        activityIndicator = UIActivityIndicatorView(frame:
                                                        CGRect(
                                                            x: UIScreen.main.bounds.size.width * 0.5,
                                                            y: UIScreen.main.bounds.size.height * 0.5,
                                                            width: 20,
                                                            height: 20)
        )
        
        self.view.addSubview(activityIndicator)
    }
    
    private func setupRx() {
        assert(viewModel != nil )
        
        let didSelect = tableView.rx
            .modelSelected(CharacterListItemViewModel.self)
            .asDriver()
        
        let input = CharacterListViewModel.Input(
            didSelectCell: didSelect
        )
        
        tableView.rx.reachedBottom()
            .do(onNext: { _ in
                debugPrint("reachedBottom reachedBottom reachedBottom")
            })
            .share(replay: 1)
            .bind(to: input.loadNextPageTrigger)
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(input: input)
        
        output.fetching
        .drive(activityIndicator.rx.isAnimating)
        .disposed(by: disposeBag)
        
        output.fetching.do {[unowned self] fetch in
            if fetch && viewModel.pageIndex > 0 {
                self.tableView.tableFooterView = self.footerIndicator
            } else {
                self.tableView.tableFooterView = nil
            }
        }
        .drive()
        .disposed(by: disposeBag)
        
        output.characters.asDriver(onErrorJustReturn: []).drive(
            tableView.rx.items(
                cellIdentifier: CharacterListItemTableViewCell.reuseIdentifier,
                cellType: CharacterListItemTableViewCell.self)) { _, viewModel, cell in
                    cell.bind(viewModel)
                }.disposed(by: disposeBag)
        
        output.error.drive(onNext: { (error) in
            debugPrint("error \(error)")
        }).disposed(by: disposeBag)
        
        output.didSelectCell
            .drive()
            .disposed(by: disposeBag)
    }
    
}
