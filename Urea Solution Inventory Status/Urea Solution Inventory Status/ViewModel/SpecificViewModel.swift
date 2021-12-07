//
//  SpecificViewModel.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/07.
//

import Foundation
import RxSwift

class SpecificViewModel {
    var dataObservable = BehaviorSubject<[UreaSolutionData]>(value: [])
    
    init() {
        _ = UreaSolutionManager.shared.fetchDataRx("")
            .map { data in
                
                return data
            }
            .bind(to: dataObservable)
    }
}
