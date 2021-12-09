//
//  SpecificView.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/09.
//

import UIKit
import SnapKit

class SpecificView: UIView {
    private let addrLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        return label
    }()
    
    private let inventoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GowunBatang-Bold", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let openTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        return label
    }()
    
    private let regDtLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        return label
    }()
    
    private let telLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        return label
    }()
    
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
    }
    
    func configure(with model: UreaSolutionData) {
        nameLabel.text = model.name
        addrLabel.text = "위치 : \(model.addr ?? "제공하지 않음")"
        inventoryLabel.text = "수량 : \(model.inventory ?? "제공하지 않음")"
        openTimeLabel.text = "영업 시간 : \(model.openTime ?? "제공하지 않음")"
        priceLabel.text = "가격 : \(model.price ?? "제공하지 않음")"
        regDtLabel.text = "업데이트 일시 : \(model.regDt ?? "제공하지 않음")"
        telLabel.text = "전화번호 : \(model.tel ?? "제공하지 않음")"
    }
}
