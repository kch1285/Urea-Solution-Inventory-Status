//
//  UreaSolutionResponse.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import Foundation

struct UreaSolutionResponse: Decodable {
    let totalCount: Int
    let currentCount: Int
    let data: [UreaSolutionData]
    let page: Int
    let perPage: Int
    let matchCount: Int
}

struct UreaSolutionData: Decodable {
    let addr: String
    let color: String?
    let inventory: String?
    let name: String
    let openTime: String?
    let price: String?
    let regDt: String?
    let tel: String?
    let code: String?
    let lat: String
    let lng: String
}
