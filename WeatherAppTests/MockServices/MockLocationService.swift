//
//  MockLocationService.swift
//  WeatherAppTests
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation
@testable import WeatherApp

class MockLocationService: BaseService, LocationServiceProtocol {
    var result: Result<SearchDataModel, NetworkError>
    
    init(result: Result<SearchDataModel, NetworkError>) {
        self.result = result
    }
    
    func searchLocation(searchText: String, limit: Int, completion: @escaping (Result<SearchDataModel, NetworkError>) -> Void) {
        completion(result)
    }  
}
