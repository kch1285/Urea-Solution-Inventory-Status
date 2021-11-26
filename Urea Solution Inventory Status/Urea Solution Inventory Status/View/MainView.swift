//
//  MainView.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func locationPressed(_ city: String)
}

class MainView: UIView {
    
    private let safeArea = UIView()
    weak var delegate: MainViewDelegate?
    
    private let gyeonginButton: UIButton = {
        let button = UIButton()
        button.setTitle("경기 / 인천", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let chungcheongButton: UIButton = {
        let button = UIButton()
        button.setTitle("충남 / 충북 / 세종", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let jeollaButton: UIButton = {
        let button = UIButton()
        button.setTitle("전남 / 전북 / 광주", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let gyeongbukButton: UIButton = {
        let button = UIButton()
        button.setTitle("경북 / 대구", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let gyeongnamButton: UIButton = {
        let button = UIButton()
        button.setTitle("경남 / 부산 / 울산", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let gangwonButton: UIButton = {
        let button = UIButton()
        button.setTitle("강원", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSafeArea()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayout()
    }
    
    private func setUpSafeArea() {
        safeArea.translatesAutoresizingMaskIntoConstraints = false
        safeArea.backgroundColor = UIColor(red: 166/255, green: 132/255, blue: 235/255, alpha: 1)
        addSubview(safeArea)
        if #available(iOS 11, *) {
            let guide = safeAreaLayoutGuide
            safeArea.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            safeArea.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            safeArea.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            safeArea.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        }
    }
    
    private func setUpViews() {
        safeArea.addSubview(gyeonginButton)
        safeArea.addSubview(chungcheongButton)
        safeArea.addSubview(jeollaButton)
        safeArea.addSubview(gyeongbukButton)
        safeArea.addSubview(gyeongnamButton)
        safeArea.addSubview(gangwonButton)
        
        gyeonginButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        chungcheongButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        jeollaButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        gyeongbukButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        gyeongnamButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        gangwonButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
    }
    
    private func setUpLayout() {
        let buttonSize = (frame.size.width - 40) / 3
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
        guard let city = button.currentTitle else {
            return
        }
        delegate?.locationPressed(city)
    }
}
