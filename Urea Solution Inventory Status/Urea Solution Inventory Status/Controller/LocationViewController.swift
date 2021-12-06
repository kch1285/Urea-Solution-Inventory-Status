//
//  RegionViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LocationViewController: UIViewController {
    
    private lazy var viewModel = LocationViewModel(cityName: cityName)
    private let disposeBag = DisposeBag()
    private var cityName = ""
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.idenrifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kk()
        setUpTableView()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.dataObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: LocationTableViewCell.idenrifier, cellType: LocationTableViewCell.self)) { index, item, cell in
                cell.textLabel?.text = item.name
                cell.textLabel?.textColor = .blue
            }
            .disposed(by: disposeBag)
    }
    
    private func kk() {
        guard let cities = title else {
            return
        }
        let city = cities.replacingOccurrences(of: " ", with: "")
        print(city)
        if city.contains("/") {
            let cityArray = city.components(separatedBy: "/")
            print(cityArray)
            for c in cityArray {
                viewModel.setCityName(c)
//                cityName = c
            }
        }
        else {
            viewModel.setCityName(city)
//            cityName = city
        }
        print(cityName)
    }
    
    private func setUpTableView() {
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        view.addSubview(tableView)
        tableView.delegate = self
        
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension LocationViewController: UITableViewDelegate {

}
