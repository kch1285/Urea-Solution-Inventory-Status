//
//  RegionTableViewCell.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/01.
//

import UIKit
import SnapKit

class LocationTableViewCell: UITableViewCell {

    static let idenrifier = "LocationTableViewCell"
    private var model: UreaSolutionResponse?
    
    private let Locationlabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "GowunBatang-Regular", size: 15)
        label.numberOfLines = 2
        return label
    }()
    
    private let inventoryColorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
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
        
        addSubview(Locationlabel)
        Locationlabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(sideInterval)
            make.centerY.equalToSuperview()
        }
        
        addSubview(inventoryColorImageView)
        inventoryColorImageView.snp.makeConstraints { make in
            make.height.width.equalTo(colorImageSize)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-sideInterval)
        }
    }

    func configure(with model: UreaSolutionData) {
        guard let color = model.color,
              let name = model.name, let inventory = model.inventory
        else {
            return
        }
        Locationlabel.text = "\(name) (\(inventory))"
        inventoryColorImageView.backgroundColor = UIColor(named: color)
    }
}
