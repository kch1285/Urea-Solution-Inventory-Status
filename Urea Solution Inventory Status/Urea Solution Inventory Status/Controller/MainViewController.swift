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
    
    let animationView: AnimationView = {
        let view = AnimationView(name: "water_animation")
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        return view
    }()
    
    let searchField: UITextField = {
        let field = UITextField()
        let placeholder = NSMutableAttributedString(string: "검색어를 입력해주세요.")
        placeholder.addAttribute(.foregroundColor, value: UIColor.systemGray2, range: NSRange(0...11))
        field.attributedPlaceholder = placeholder
        field.textColor = .red
        return field
    }()
    
    private let gyeonginButton: UIButton = {
        let button = UIButton()
        button.setTitle("경기 / 인천", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let chungcheongButton: UIButton = {
        let button = UIButton()
        button.setTitle("충남 / 충북 / 세종", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let jeollaButton: UIButton = {
        let button = UIButton()
        button.setTitle("전남 / 전북 / 광주", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let gyeongbukButton: UIButton = {
        let button = UIButton()
        button.setTitle("경북 / 대구", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let gyeongnamButton: UIButton = {
        let button = UIButton()
        button.setTitle("경남 / 부산 / 울산", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let gangwonButton: UIButton = {
        let button = UIButton()
        button.setTitle("강원", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpMainView()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async { [weak self] in
            self?.animationView.play()
        }
    }
    
    
    private func setUpMainView() {
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        
        view.addSubview(animationView)
        view.addSubview(searchField)
        view.addSubview(gyeonginButton)
        view.addSubview(chungcheongButton)
        view.addSubview(jeollaButton)
        view.addSubview(gyeongbukButton)
        view.addSubview(gyeongnamButton)
        view.addSubview(gangwonButton)
        
        gyeonginButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        chungcheongButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        jeollaButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        gyeongbukButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        gyeongnamButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        gangwonButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        let buttonSize = (view.frame.size.width - 40) / 3
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(view.frame.height * 0.15)
        }
        
        chungcheongButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonSize)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().dividedBy(2).offset(10)
        }
        
        gyeonginButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonSize)
            make.top.equalTo(chungcheongButton)
            make.trailing.equalTo(chungcheongButton.snp.leading).offset(-10)
        }
        
        jeollaButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonSize)
            make.top.equalTo(chungcheongButton)
            make.leading.equalTo(chungcheongButton.snp.trailing).offset(10)
        }
        
        gyeongnamButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonSize)
            make.top.equalTo(chungcheongButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        gyeongbukButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonSize)
            make.top.equalTo(gyeongnamButton)
            make.trailing.equalTo(gyeongnamButton.snp.leading).offset(-10)
        }
        
        gangwonButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonSize)
            make.top.equalTo(gyeongnamButton)
            make.leading.equalTo(gyeongnamButton.snp.trailing).offset(10)
        }
    }
    
    @objc private func didTapButton(_ button: UIButton) {
        let vc = LocationViewController()
        vc.title = button.currentTitle
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
