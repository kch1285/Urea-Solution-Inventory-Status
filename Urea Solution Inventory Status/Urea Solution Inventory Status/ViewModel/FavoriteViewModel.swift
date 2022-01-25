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
                setFavoriteList()
                NotificationCenter.default.post(name: Notification.Name("ob"), object: nil)
            }
        }
    }
    
    func getFavoriteList() -> [Favorite] {
        guard let data = UserDefaults.standard.value(forKey: "favorites") as? Data else {
            return []
        }
        FavoriteViewModel.favoriteList = try! PropertyListDecoder().decode([Favorite].self, from: data)
        return try! PropertyListDecoder().decode([Favorite].self, from: data)
    }
    
    static private func setFavoriteList() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(FavoriteViewModel.favoriteList), forKey: "favorites")
    }
    
    func checkFavorite(_ address: String) -> Bool {
        if getFavoriteList().filter({ $0.data.addr == address }).count == 1 {
            return true
        }
        return false
    }
    
    func addFavoriteEntity(_ favorite: Favorite) {
        FavoriteViewModel.favoriteList.append(favorite)
    }
    
    func removeFavoriteEntity(_ favorite: Favorite) {
        FavoriteViewModel.favoriteList.removeAll { $0.data.addr == favorite.data.addr }
    }
    
    func getFavoriteListCount() -> Int {
        return getFavoriteList().count
    }
}
