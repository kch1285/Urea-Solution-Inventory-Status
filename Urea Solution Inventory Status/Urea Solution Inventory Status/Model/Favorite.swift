//
//  Favorites.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2022/01/02.
//

import Foundation

struct Favorite: Codable, Equatable {
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.data.addr == rhs.data.addr
    }
    
    let data: UreaSolutionData
    var isAdded: Bool
}
