//
//  MockUserDefaults.swift
//  WeatherAppTests
//
//  Created by Priyanka Vibhute on 12/04/23.
//

import Foundation
@testable import WeatherApp

class MockUserDefaults: BaseService, UserDefaultManagerProtocol {
    func save(city: WeatherApp.City) {
    }
    
    func getCity() -> WeatherApp.City {
        return City(name: "Pune", lat: 18.5204, lon: 73.8567)
    }
}
    
