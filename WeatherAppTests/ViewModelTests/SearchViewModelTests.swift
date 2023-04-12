//
//  SearchViewModelTests.swift
//  WeatherAppTests
//
//  Created by Priyanka Vibhute on 12/04/23.
//

import XCTest
@testable import WeatherApp

final class SearchViewModelTests: XCTestCase {
    //I can add test cases for remaining files that need to cover under unit test cases but due to time constraint coudn't complete that.
    
    func test_location_API_success() {
        let mockLocationService = MockLocationService(result: .success(getLocationDataModel()))
        let sut = SearchViewModel(locationService: mockLocationService, searchCoordinator: SearchCoordinator(navigationController: UINavigationController(), parentView: HomeCoordinator(navigationController: UINavigationController())))
        sut.searchLocation(text: "Pune") { _ in
            XCTAssertEqual(sut.cities[0].name, "Pune")
        }
    }
    
    func test_location_API_failure() {
        let mockLocationService = MockLocationService(result: .failure(NetworkError.apiError))
        let sut = SearchViewModel(locationService: mockLocationService, searchCoordinator: SearchCoordinator(navigationController: UINavigationController(), parentView: HomeCoordinator(navigationController: UINavigationController())))
        sut.searchLocation(text: "Pune") { result in
            XCTAssertEqual(sut.cities.count, 0)
        }
    }
    
    func getLocationDataModel() -> SearchDataModel {
        SearchDataModel(cities: [City(name: "Pune", lat: 18.5204, lon: 73.8567),
                                 City(name: "Satara", lat: 17.5204, lon: 71.8567)])
    }
}
