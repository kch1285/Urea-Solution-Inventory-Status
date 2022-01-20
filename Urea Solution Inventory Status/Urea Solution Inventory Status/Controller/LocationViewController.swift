//
//  RegionViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import UIKit
import SnapKit
import Then

class LocationViewController: UIViewController {
    lazy var cityName = "" {
        didSet {
            DispatchQueue.main.async {
                self.title = self.cityName + " (\(self.data.count))"
            }
        }
    }
    
    lazy var searchResult = "" {
        didSet {
            DispatchQueue.main.async {
                self.title = """
                            "\(self.searchResult)" 검색 결과 (\(self.data.count))
                            """
            }
        }
    }
    
    var data: [UreaSolutionData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private let tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 500
        $0.backgroundColor = .clear
        $0.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.idenrifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("LocationViewController - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("LocationViewController - viewDidDisappear")
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
