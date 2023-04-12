//
//  MockDownloadImageService.swift
//  WeatherAppTests
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation
@testable import WeatherApp

class MockDownloadImageService: BaseService, DownloadImageServiceProtocol {
    var result: Result<WeatherIconModel, NetworkError>
    
    init(result: Result<WeatherIconModel, NetworkError>) {
        self.result = result
    }
    
    func getImage(name: String, completion: @escaping (Result<WeatherIconModel, NetworkError>) -> Void) {
        completion(result)
    }
}
