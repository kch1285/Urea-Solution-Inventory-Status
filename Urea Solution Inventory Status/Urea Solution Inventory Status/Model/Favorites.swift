//
//  Favorites.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2022/01/02.
//

import Foundation
import RealmSwift

class Favorites: Object {
    @objc dynamic var favorite: UreaSolutionData = []
    @objc dynamic var name: String = ""
    @objc dynamic var isFavorite: Bool = false
//    let addr: String
//    let color: String?
//    let inventory: String?
//    let name: String
//    let openTime: String?
//    let price: String?
//    let regDt: String?
//    let tel: String?
//    let code: String?
//    let lat: String
//    let lng: String
}
