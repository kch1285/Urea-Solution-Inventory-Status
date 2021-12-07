//
//  RegionTableViewCell.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/01.
//

import UIKit
import RxCocoa

class LocationTableViewCell: UITableViewCell {

    static let idenrifier = "LocationTableViewCell"
    private var model: UreaSolutionResponse?
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
