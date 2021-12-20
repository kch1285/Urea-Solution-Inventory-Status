//
//  ViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import UIKit
import Lottie
import SnapKit

class MainViewController: UIViewController {

    private let locations: [String] = [
        "서울", "경기", "인천", "강원", "충남",
        "충북", "대전", "세종", "전북", "전남",
        "경북", "경남", "부산", "울산", "대구",
        "광주", "제주"
    ]
    
    private var numbers: [Int] = []
    
    private let animationView: AnimationView = {
        let view = AnimationView(name: "water_animation")
        view.contentMode = .scaleAspectFit
        view.backgroundBehavior = .stop
        view.loopMode = .loop
        return view
    }()

    private let searchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let searchField: UITextField = {
        let field = UITextField()
        let placeholder = NSMutableAttributedString(string: "주유소 이름")
        placeholder.addAttribute(.foregroundColor, value: UIColor.systemGray2, range: NSRange(0...5))
        field.attributedPlaceholder = placeholder
        field.font = UIFont(name: "GowunBatang-Regular", size: 20)
        field.textColor = .systemGray2
        field.backgroundColor = UIColor(named: "searchFieldBackgroundColor")
        field.setRoundedRectangle()
        return field
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "GowunBatang-Regular", size: 13)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpMainView()
        navigationBarSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animationView.play()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    private func setUpMainView() {
        let buttonSize = (view.frame.size.width - 60) / 5
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        
        view.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo((view.frame.size.width - 60) / 4)
            make.top.equalToSuperview().offset(view.frame.size.height / 10)
            make.leading.equalToSuperview().offset(view.frame.size.width / 15)
        }
        
        view.addSubview(searchField)
        searchField.snp.makeConstraints { make in
            make.centerY.equalTo(animationView)
            make.leading.equalTo(animationView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-view.frame.size.width / 15)
            make.height.equalTo(animationView.snp.height).dividedBy(2)
        }
        
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchField)
            make.width.height.equalTo(searchField.snp.height)
            make.trailing.equalTo(searchField)
        }
        
        for (index, location) in locations.enumerated() {
            let button = UIButton()
            button.setTitle("\(location)", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 8
            button.titleLabel?.font = UIFont(name: "GowunBatang-Regular", size: 20)
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            view.addSubview(button)
            
            if index < 5 {
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)
                    make.top.equalTo(animationView.snp.bottom).offset(10)
                    make.leading.equalToSuperview().offset(10 * (index + 1) + (Int(buttonSize) * index))
                }
            }
            else if index < 10 {
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)
                    make.top.equalTo(animationView.snp.bottom).offset(buttonSize + 20)
                    make.leading.equalToSuperview().offset(10 * (index - 4) + (Int(buttonSize) * (index - 5)))
                }
            }
            else if index < 15 {
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)
                    make.top.equalTo(animationView.snp.bottom).offset(buttonSize * 2 + 30)
                    make.leading.equalToSuperview().offset(10 * (index - 9) + (Int(buttonSize) * (index - 10)))
                }
            }
            else {
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)
                    make.top.equalTo(animationView.snp.bottom).offset(buttonSize * 3 + 40)
                    make.leading.equalToSuperview().offset(10 * (index - 14) + (Int(buttonSize) * (index - 15)))
                }
                if index == 15 {
                    view.addSubview(infoLabel)
                    infoLabel.snp.makeConstraints { make in
                        make.top.equalTo(button.snp.bottom).offset(10)
                        make.trailing.equalToSuperview().offset(-10)
                        make.leading.equalTo(button)
                    }
                }
            }
        }
    }
    
    private func navigationBarSetting() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .clear
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.clipsToBounds = true

    }
    
    @objc private func didTapButton(_ button: UIButton) {
        guard let city = button.currentTitle else {
            return
        }
        
        let vc = LocationViewController()
        view.endEditing(true)
        UreaSolutionManager.shared.fetchInventory(data: city, flag: 0) { [weak self] result in
            switch result {
            case .success(let data):
                vc.data = data
                DispatchQueue.main.async {
                    vc.tableView.reloadData()
                    vc.title = city
                    self?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "GowunBatang-Bold", size: 20)!]
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showNetworkAlert()
                }
            }
        }
    }
    
    @objc private func didTapSearchButton() {
        guard let station = searchField.text else {
            return
        }
        
        let vc = LocationViewController()
        view.endEditing(true)
        UreaSolutionManager.shared.fetchInventory(data: station, flag: 1) { [weak self] result in
            switch result {
            case .success(let data):
                vc.data = data
                DispatchQueue.main.async {
                    vc.tableView.reloadData()
                    vc.title = """
                    "\(station)" 검색 결과
                    """
                    self?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "GowunBatang-Bold", size: 20)!]
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showNetworkAlert()
                }
            }
        }
    }
    
    private func showNetworkAlert() {
        let alert = UIAlertController(title: "네트워크 오류", message: "네트워크 연결 상태를 확인해주세요.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
