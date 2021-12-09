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
    private let locations: [String] = ["경기", "인천", "충남", "충북",
                                       "세종", "전남", "전북", "광주",
                                       "경북", "대구", "경남", "부산",
                                       "울산", "강원"
    ]
    
    let animationView: AnimationView = {
        let view = AnimationView(name: "water_animation")
        view.contentMode = .scaleAspectFit
        view.backgroundBehavior = .stop
        view.loopMode = .loop
        return view
    }()
//
//    let searchField: UITextField = {
//        let field = UITextField()
//        let placeholder = NSMutableAttributedString(string: "검색어를 입력해주세요.")
//        placeholder.addAttribute(.foregroundColor, value: UIColor.systemGray2, range: NSRange(0...11))
//        field.attributedPlaceholder = placeholder
//        field.textColor = .red
//        return field
//    }()
    
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
        
        DispatchQueue.main.async { [weak self] in
            self?.animationView.play()
        }
    }
    
    
    private func setUpMainView() {
        let buttonSize = (view.frame.size.width - 100) / 4
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        
        view.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.width.equalTo((view.frame.size.width - 60) / 2)
            make.height.equalTo((view.frame.size.width * 3 - 160) / 4)
            make.center.equalToSuperview()
        }
        
        for (index, location) in locations.enumerated() {
            let button = UIButton()
            button.setTitle(location, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 8
            button.titleLabel?.font = UIFont(name: "GowunBatang-Regular", size: 20)
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            view.addSubview(button)
            
            if index < 4 {
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)
                    make.bottom.equalTo(animationView.snp.top).offset(-20)
                    make.leading.equalToSuperview().offset(20 * (index + 1) + (Int(buttonSize) * index))
                }
            }
            else if index < 10 {
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)

                    if index % 2 == 0 {
                        make.trailing.equalTo(animationView.snp.leading).offset(-20)
                        make.top.equalTo(animationView).offset((20 + Int(buttonSize)) * ((index - 4)) / 2)
                    }
                    else {
                        make.leading.equalTo(animationView.snp.trailing).offset(20)
                        make.top.equalTo(animationView).offset((20 + Int(buttonSize)) * ((index - 5)) / 2)
                    }
                }
            }
            else {
                button.snp.makeConstraints { make in
                    make.width.height.equalTo(buttonSize)
                    make.top.equalTo(animationView.snp.bottom).offset(20)
                    make.leading.equalToSuperview().offset(20 * (index - 9) + (Int(buttonSize) * (index - 10)))
                }
                
                if index == 10 {
                    view.addSubview(infoLabel)
                    infoLabel.snp.makeConstraints { make in
                        make.top.equalTo(button.snp.bottom).offset(20)
                        make.trailing.equalToSuperview().offset(-20)
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
        
        UreaSolutionManager.shared.fetchData(city) { [weak self] result in
            switch result {
            case .success(let data):
                vc.data = data
                DispatchQueue.main.async {
                    vc.tableView.reloadData()
                    vc.title = button.currentTitle
                    self?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "GowunBatang-Bold", size: 20)!]
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}