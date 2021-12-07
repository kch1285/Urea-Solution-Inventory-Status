//
//  UreaManager.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import Foundation
import RxSwift

struct UreaSolutionManager {
    static var shared = UreaSolutionManager()
    private init() {}
    
    private let baseURL = "https://api.odcloud.kr/api/uws/v1/inventory?serviceKey=hYcfU37i4SB4wniwRXtVJleV5833j6KiQM8cl3rBy4ihYSGRomdo%2BCcbLl2YPbyWbCoHyhGPQSUOQAnjr2IRYA%3D%3D&page=1&perPage=9999"

    func fetchDataRx(_ city: String) -> Observable<[UreaSolutionData]> {
        return Observable.create { emitter in
            fetchData(city) { result in
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchData(_ city: String, completion: @escaping (Result<[UreaSolutionData], Error>) -> Void) {
        guard let encodedString = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let urlString = "\(baseURL)&cond%5Baddr%3A%3ALIKE%5D=\(encodedString)"
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let result = try JSONDecoder().decode(UreaSolutionResponse.self, from: data)
                var fetchResults: [UreaSolutionData] = []
                fetchResults.append(contentsOf: result.data)
                completion(.success(fetchResults))
            }
            catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
