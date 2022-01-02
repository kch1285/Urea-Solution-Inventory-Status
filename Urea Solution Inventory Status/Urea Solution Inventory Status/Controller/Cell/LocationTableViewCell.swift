//
//  RegionTableViewCell.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/01.
//

import UIKit
import SnapKit
import Then

class LocationTableViewCell: UITableViewCell {

    static let idenrifier = "LocationTableViewCell"
    private var model: UreaSolutionResponse?
    
    private let Locationlabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont(name: "GowunBatang-Regular", size: 15)
        $0.numberOfLines = 0
    }
    
    private let inventoryColorImageView = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setUpCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCells() {
        let colorImageSize: CGFloat = frame.size.height / 2
        let sideInterval = colorImageSize / 2
        
        addSubview(inventoryColorImageView)
        inventoryColorImageView.snp.makeConstraints { make in
            make.height.width.equalTo(colorImageSize)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
        
        addSubview(Locationlabel)
        Locationlabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(sideInterval)
            make.trailing.equalTo(inventoryColorImageView.snp.leading).offset(-sideInterval)
            make.centerY.equalToSuperview()
        }
    }

    func configure(with model: UreaSolutionData) {
        guard let color = model.color, let inventory = model.inventory else {
            return
        }
        Locationlabel.text = "\(model.name) (\(inventory))"
        inventoryColorImageView.backgroundColor = UIColor(named: color)
    }
    
    func configure(with favorite: Favorite) {
        guard let color = favorite.color, let inventory = favorite.inventory else {
            return
        }
        Locationlabel.text = "\(favorite.name) (\(inventory))"
        inventoryColorImageView.backgroundColor = UIColor(named: color)
    }
}
