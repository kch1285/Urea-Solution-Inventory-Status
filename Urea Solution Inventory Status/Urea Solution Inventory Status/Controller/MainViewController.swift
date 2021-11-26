//
//  ViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import UIKit

class MainViewController: UIViewController {

    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UreaSolutionManager.shared.delegate = self
        UreaSolutionManager.shared.fetchData("경기")
        setUpMainView()
    }
    
    private func setUpMainView() {
        view.addSubview(mainView)
        mainView.delegate = self
        mainView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}


extension MainViewController: UreaSolutionManagerDelegate {
    func fetchUreaSolution(_ ureaSolution: UreaSolutionResponse) {
     //   print(ureaSolution.data[2].price)
        print(ureaSolution)
    }
}

extension MainViewController: MainViewDelegate {
    func locationPressed(_ city: String) {
        print(city)
        let vc = RegionViewController()
        vc.title = city
        navigationController?.pushViewController(vc, animated: true)
    }
}
