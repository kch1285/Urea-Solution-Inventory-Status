//
//  LocationViewModel.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/12/04.
//

import Foundation
import RxSwift

class LocationViewModel {
    
    var dataObservable = BehaviorSubject<[UreaSolutionData]>(value: [])
    var cityName: String
    
    let ureaSolutionDataCount: Int = 0
    
    func setCityName(_ city: String) {
        cityName = city
    }
    
    init(cityName: String) {
        self.cityName = cityName
        _ = UreaSolutionManager.shared.fetchDataRx("")
            .map { data in
                var fetchResults: [UreaSolutionData] = []
                do {
                    let result = try JSONDecoder().decode(UreaSolutionResponse.self, from: data)
                    print(result)

                    fetchResults.append(contentsOf: result.data)
                }
                catch {
                    print(error.localizedDescription)
                }
                return fetchResults
            }
            
            .bind(to: dataObservable)
    }
}
