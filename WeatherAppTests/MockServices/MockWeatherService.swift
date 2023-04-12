//
//  MockWeatherService.swift
//  WeatherAppTests
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation
@testable import WeatherApp

class MockWeatherService: BaseService, WeatherServiceProtocol {
    
    var result: Result<HomeModel, NetworkError>
    
    init(result: Result<HomeModel, NetworkError>) {
        self.result = result
    }
    
    func getWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<HomeModel, NetworkError>) -> Void) {
        completion(result)
    }
}
