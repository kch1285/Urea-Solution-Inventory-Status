//
//  Favorites.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2022/01/02.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var addr: String = ""
    @objc dynamic var color: String?
    @objc dynamic var inventory: String?
    @objc dynamic var openTime: String?
    @objc dynamic var price: String?
    @objc dynamic var regDt: String?
    @objc dynamic var tel: String?
    @objc dynamic var code: String?
    @objc dynamic var lat: String = ""
    @objc dynamic var lng: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var imageName: String = "emptyStar"
}
