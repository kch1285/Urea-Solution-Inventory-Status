//
//  SpecificView.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/09.
//

import UIKit
import SnapKit
import Then

protocol SpecificViewDelegate: AnyObject {
    func phoneCall()
    func kakaoNavi()
    func favorites()
}

class SpecificView: UIView {
    weak var delegate: SpecificViewDelegate?
    let buttonSize = 50
    private let addrLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "GowunBatang-Regular", size: 20)
    }
    
    private let inventoryLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "GowunBatang-Regular", size: 20)
    }
    
    private let nameLabel = UILabel().then {
        $0.font = UIFont(name: "GowunBatang-Bold", size: 30)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let openTimeLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "GowunBatang-Regular", size: 20)
    }
    
    private let infoLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "GowunBatang-Regular", size: 20)
    }
    
    private let priceLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "GowunBatang-Regular", size: 20)
    }
    
    private let regDtLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "GowunBatang-Regular", size: 20)
    }
    
    let telLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont(name: "GowunBatang-Regular", size: 20)
    }
    
    private let callButton = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "phone"), for: .normal)
        $0.backgroundColor = UIColor(named: "backgroundColor")
        $0.tintColor = .black
        $0.setRoundedRectangle()
    }
    
    private let naviButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "kakaonavi"), for: .normal)
        $0.setRoundedRectangle()
    }
    
    let starButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "emptyStar"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpViews() {
        backgroundColor = .clear
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(5)
            make.leading.top.equalToSuperview()
        }
        
        addSubview(addrLabel)
        addrLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
        addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(addrLabel)
            make.top.equalTo(addrLabel.snp.bottom).offset(10)
        }
        
        addSubview(inventoryLabel)
        inventoryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(addrLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
        }
        
        addSubview(openTimeLabel)
        openTimeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(addrLabel)
            make.top.equalTo(inventoryLabel.snp.bottom).offset(10)
        }
        
        addSubview(telLabel)
        telLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(addrLabel)
            make.top.equalTo(openTimeLabel.snp.bottom).offset(10)
        }
        
        addSubview(regDtLabel)
        regDtLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(addrLabel)
            make.top.equalTo(telLabel.snp.bottom).offset(10)
        }
        
        addSubview(naviButton)
        naviButton.addTarget(self, action: #selector(didTapNaviButton), for: .touchUpInside)
        naviButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.top.equalTo(regDtLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        addSubview(callButton)
        callButton.addTarget(self, action: #selector(didTapCallButton), for: .touchUpInside)
        callButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.top.equalTo(naviButton)
            make.centerX.equalToSuperview().offset(-buttonSize * 2)
        }
        
        addSubview(starButton)
        starButton.addTarget(self, action: #selector(didTapStarButton), for: .touchUpInside)
        starButton.snp.makeConstraints { make in
            make.size.equalTo(buttonSize)
            make.top.equalTo(naviButton)
            make.centerX.equalToSuperview().offset(buttonSize * 2)
        }
    }
    
    func configure(with model: Favorite) {
        nameLabel.text = model.data.name
        addrLabel.text = "위치 : \(model.data.addr)"
        inventoryLabel.text = "수량 : \(model.data.inventory ?? "제공하지 않음")"
        openTimeLabel.text = "영업 시간 : \(model.data.openTime ?? "제공하지 않음")"
        priceLabel.text = "가격 : \(model.data.price ?? "제공하지 않음")"
        regDtLabel.text = "업데이트 일시 : \(model.data.regDt ?? "제공하지 않음")"
        telLabel.text = "전화번호 : \(model.data.tel ?? "제공하지 않음")"
        starButton.setBackgroundImage(UIImage(named: model.isAdded ? "yellowStar" : "emptyStar"), for: .normal)
    }
    
    @objc private func didTapCallButton() {
        delegate?.phoneCall()
    }
    
    @objc private func didTapNaviButton() {
        delegate?.kakaoNavi()
    }
    
    @objc private func didTapStarButton() {
        delegate?.favorites()
    }
}
