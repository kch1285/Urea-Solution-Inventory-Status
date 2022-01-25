//
//  UreaManager.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import Foundation
import Alamofire

class UreaSolutionManager {
    static var shared = UreaSolutionManager()
    private init() {}
    
    private let baseURL = "https://api.odcloud.kr/api/uws/v1/inventory"

    func fetchInventory(about city: String = "", station: String = "", completion: @escaping (Result<[UreaSolutionData], Error>) -> Void) {
        let parameters: [String: Any] = [
            "serviceKey": ServiceKey.seviceKey,
            "cond[addr::LIKE]": city,
            "cond[name::LIKE]": station,
            "perPage": 9999
          ]

        
        AF.request(baseURL, parameters: parameters) { urlRequest in
            urlRequest.timeoutInterval = 5
        }
        .validate()
        .responseDecodable(of: UreaSolutionResponse.self) { response in
            guard let data = response.value?.data, response.error == nil else {
                completion(.failure(response.error!))
                return
            }
            var fetchResults: [UreaSolutionData] = []
            fetchResults.append(contentsOf: data)
            completion(.success(fetchResults))
        }
    }
}
