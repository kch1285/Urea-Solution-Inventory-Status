//
//  RegionViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import UIKit
import SnapKit
//import RxSwift
//import RxCocoa

class LocationViewController: UIViewController {
    private var cityName = ""
//    private lazy var viewModel = LocationViewModel(cityName: cityName)
    var data: [UreaSolutionData] = []
    var flag = false
 //   private let disposeBag = DisposeBag()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.idenrifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityName = title!
        verification()
        title = "\(title!) (\(data.count))"
        setUpTableView()
        
      //  bindViewModel()
    }

//    private func bindViewModel() {
//        viewModel.dataObservable
//            .observe(on: MainScheduler.instance)
//            .bind(to: tableView.rx.items(cellIdentifier: LocationTableViewCell.idenrifier, cellType: LocationTableViewCell.self)) { index, item, cell in
//                cell.textLabel?.text = "\(item.name) (\(item.inventory))"
//                cell.textLabel?.textColor = .black
//            }
//            .disposed(by: disposeBag)
//    }
    
    private func verification() {
        if flag {
            data.removeAll { !$0.addr.hasPrefix(cityName) }
        }
    }
    
    private func setUpTableView() {
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension LocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SpecificViewController()
        vc.specificData = data[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.idenrifier, for: indexPath) as! LocationTableViewCell
        cell.configure(with: data[indexPath.row])
        return cell
    }
}
