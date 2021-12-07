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
    private var cityName = ""
    private lazy var viewModel = LocationViewModel(cityName: cityName)
    private let disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.idenrifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName = title!
        setUpTableView()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.dataObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: LocationTableViewCell.idenrifier, cellType: LocationTableViewCell.self)) { index, item, cell in
                cell.textLabel?.text = "\(item.name) (\(item.inventory))"
                cell.textLabel?.textColor = .black
            }
            .disposed(by: disposeBag)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(tableView)
        
        let vc = SpecificViewController()
        present(vc, animated: true, completion: nil)
    }
}
