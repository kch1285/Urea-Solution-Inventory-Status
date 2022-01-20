//
//  SpecificViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/07.
//

import UIKit
import SnapKit
import KakaoSDKNavi
import Then

class SpecificViewController: UIViewController {
    var specificData: UreaSolutionData!
    private let specificView = SpecificView()
    private var favorite: Favorite!
    private let viewModel = FavoriteViewModel()
    
    private let toastLabel = UILabel().then {
        $0.backgroundColor = .black.withAlphaComponent(0.6)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont(name: "GowunBatang-Regular", size: 20)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSpecificView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SpecificViewController - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SpecificViewController - viewDidDisappear")
    }
    private func setUpSpecificView() {
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        view.addSubview(specificView)
        specificView.delegate = self
        favorite = Favorite(data: specificData, isAdded: viewModel.checkFavorite(specificData.addr))
        specificView.configure(with: favorite)
        
        specificView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func showToast(_ message: String) {
        toastLabel.text = message
        toastLabel.alpha = 1
        view.addSubview(toastLabel)
        toastLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut) {
            self.toastLabel.alpha = 0
        } completion: { _ in
            self.toastLabel.removeFromSuperview()
        }
    }
    
}

//MARK: - SpecificViewDelegate
extension SpecificViewController: SpecificViewDelegate {
    func favorites() {
        // 즐겨찾기 추가
        if !viewModel.checkFavorite(specificData.addr) {
            favorite.isAdded = true
            viewModel.addFavoriteEntity(favorite)
            showToast(" 즐겨찾기에 추가되었습니다. ")
            specificView.starButton.setBackgroundImage(UIImage(named: "yellowStar"), for: .normal)
        }
        // 즐겨찾기 해제
        else {
            favorite.isAdded = false
            specificView.starButton.setBackgroundImage(UIImage(named: "emptyStar"), for: .normal)
            viewModel.removeFavoriteEntity(favorite)
            showToast(" 즐겨찾기에서 삭제되었습니다. ")
        }
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
