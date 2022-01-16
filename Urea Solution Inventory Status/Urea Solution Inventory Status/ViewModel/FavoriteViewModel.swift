//
//  FavoriteViewModel.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2022/01/16.
//

import Foundation

class FavoriteViewModel {
    static var favoriteList: [Favorite] = [] {
        didSet {
            if favoriteList != oldValue {
                print("didSet")
                setFavoriteList()
                NotificationCenter.default.post(name: Notification.Name("ob"), object: nil)
            }
        }
    }
    
    static func getFavoriteList() -> [Favorite] {
        guard let data = UserDefaults.standard.value(forKey: "favorites") as? Data else {
            return []
        }
        FavoriteViewModel.favoriteList = try! PropertyListDecoder().decode([Favorite].self, from: data)
        return try! PropertyListDecoder().decode([Favorite].self, from: data)
    }
    
    static private func setFavoriteList() {
        print("setFavoriteList")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(FavoriteViewModel.favoriteList), forKey: "favorites")
    }
    
    static func checkFavorite(_ address: String) -> Bool {
        if FavoriteViewModel.getFavoriteList().filter({ $0.data.addr == address }).count == 1 {
            return true
        }
        return false
    }
    
    static func addFavoriteEntity(_ favorite: Favorite) {
        print("addFavoriteEntity")
        FavoriteViewModel.favoriteList.append(favorite)
    }
    
    static func removeFavoriteEntity(_ favorite: Favorite) {
        print("removeFavoriteEntity")
        FavoriteViewModel.favoriteList.removeAll { $0.data.addr == favorite.data.addr }
    }
    
    static func getFavoriteListCount() -> Int {
        print("getFavoriteListCount \(FavoriteViewModel.getFavoriteList().count)")
        return FavoriteViewModel.getFavoriteList().count
    }
}
