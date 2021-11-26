//
//  UreaManager.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2021/11/26.
//

import Foundation

protocol UreaSolutionManagerDelegate: AnyObject {
    func fetchUreaSolution(_ ureaSolution: UreaSolutionResponse)
}

struct UreaSolutionManager {
    static var shared = UreaSolutionManager()
    private init() {}
    var delegate: UreaSolutionManagerDelegate?
    
    private let baseURL = "https://api.odcloud.kr/api/uws/v1/inventory?serviceKey=hYcfU37i4SB4wniwRXtVJleV5833j6KiQM8cl3rBy4ihYSGRomdo%2BCcbLl2YPbyWbCoHyhGPQSUOQAnjr2IRYA%3D%3D&page=1&perPage=9999"
    
    //hYcfU37i4SB4wniwRXtVJleV5833j6KiQM8cl3rBy4ihYSGRomdo%252BCcbLl2YPbyWbCoHyhGPQSUOQAnjr2IRYA%253D%253D
    //hYcfU37i4SB4wniwRXtVJleV5833j6KiQM8cl3rBy4ihYSGRomdo%2BCcbLl2YPbyWbCoHyhGPQSUOQAnjr2IRYA%3D%3D
    //hYcfU37i4SB4wniwRXtVJleV5833j6KiQM8cl3rBy4ihYSGRomdo%252BCcbLl2YPbyWbCoHyhGPQSUOQAnjr2IRYA%253D%253D
    func fetchData() {
        let urlString = baseURL
        performRequest(with: urlString)
    }
    
    func fetchData(_ city: String) {
        guard let encodedString = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let urlString = "\(baseURL)&cond%5Baddr%3A%3ALIKE%5D=\(encodedString)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let ureaData = data, error == nil else {
                return
            }
            guard let ureaSolution = parseJSON(ureaData) else {
                return
            }
            delegate?.fetchUreaSolution(ureaSolution)
        }
        task.resume()
    }
    
    private func parseJSON(_ ureaData: Data) -> UreaSolutionResponse? {
        do {
            let result = try JSONDecoder().decode(UreaSolutionResponse.self, from: ureaData)
            return result
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
