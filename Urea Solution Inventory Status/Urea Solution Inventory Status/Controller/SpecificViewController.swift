//
//  SpecificViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/07.
//

import UIKit
import SnapKit

class SpecificViewController: UIViewController {
    var specificData: UreaSolutionData!
    let specificView = SpecificView()
    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .clear
//        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.idenrifier)
//        return tableView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

 //       setUpTableView()
      //  bindViewModel()
        setUpSpecificView()
    }
    
//    private func setUpTableView() {
//        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
//        view.addSubview(tableView)
//
//        tableView.snp.makeConstraints { make in
//            make.size.equalToSuperview()
//        }
//    }
    
    private func setUpSpecificView() {
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        view.addSubview(specificView)
        specificView.configure(with: specificData)
        
        specificView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
//    private func bindViewModel() {
//        viewModel.dataObservable
//            .observe(on: MainScheduler.instance)
//            .bind(to: tableView.rx.items(cellIdentifier: LocationTableViewCell.idenrifier, cellType: LocationTableViewCell.self)) { index, item, cell in
//                cell.textLabel?.text = item.addr
//                cell.textLabel?.textColor = .black
//            }
//            .disposed(by: disposeBag)
//    }

}
