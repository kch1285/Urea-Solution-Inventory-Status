//
//  SpecificViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/07.
//

import UIKit
import SnapKit
import KakaoSDKNavi

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
        specificView.delegate = self
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


extension SpecificViewController: SpecificViewDelegate {
    func favorites() {
        specificView.starButton.setBackgroundImage(UIImage(named: "yellowStar"), for: .normal)
    }
    
    func kakaoNavi() {
        let destination = NaviLocation(name: specificData.name, x: specificData.lng, y: specificData.lat)
        let option = NaviOption(coordType: .WGS84)
        
        guard let navigateUrl = NaviApi.shared.navigateUrl(destination: destination, option: option) else {
            return
        }

        if UIApplication.shared.canOpenURL(navigateUrl) {
            UIApplication.shared.open(navigateUrl, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.open(NaviApi.webNaviInstallUrl, options: [:], completionHandler: nil)
        }
    }
    
    func phoneCall() {
        guard let text = specificView.telLabel.text else {
            return
        }
        
        let number = text.filter { $0.isNumber }
        
        if number == "" {
            showNetworkAlert()
        }
        else {
            let numberURL = "tel://" + number
            if let url = NSURL(string: numberURL),
               UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
            else {
                showNetworkAlert()
            }
        }
    }
    
    private func showNetworkAlert() {
        let alert = UIAlertController(title: "전화번호 오류", message: "전화번호가 유효하지 않거나 제공하지 않습니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
