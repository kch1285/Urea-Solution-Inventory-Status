//
//  SpecificViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/07.
//

import UIKit
import RxSwift
import RxCocoa

class SpecificViewController: UIViewController {

    private let viewModel = SpecificViewModel()
    private let label = UILabel()
    private let disposeBag = DisposeBag()
    private let label2 = UILabel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.idenrifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        bindViewModel()
    }
    
    private func setUpTableView() {
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.dataObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: LocationTableViewCell.idenrifier, cellType: LocationTableViewCell.self)) { index, item, cell in
                cell.textLabel?.text = item.addr
//                let addr: String
//                let color: String
//                let inventory: String
//                let name: String
//                let openTime: String?
//                let price: String?
//                let regDt: String
//                let tel: String
//                let code: String
//                let lat: String
//                let lng: String
                cell.textLabel?.textColor = .black
            }
            .disposed(by: disposeBag)
    }
//    private func bindViewModel() {
//        viewModel.dataObservable
//            .observe(on: MainScheduler.instance)
//            .bind(to: label.rx.base)
//            .disposed(by: disposeBag)
//    }
//    private func bindToViewModel() {
//        searchField.textfield.rx.text.orEmpty
//            .bind(to: vm.input.searchWord)
//            .disposed(by: disposeBag)
//
//        searchField.button.rx.tap
//            .bind(to: vm.input.searchButton)
//            .disposed(by: disposeBag)
//
//        favoriteEditButton.rx.tap
//            .bind(to: vm.input.favoriteEditButton)
//            .disposed(by: disposeBag)
//    }
}
