//
//  HomeViewModelTests.swift
//  WeatherAppTests
//
//  Created by Priyanka Vibhute on 12/04/23.
//

import XCTest
@testable import WeatherApp

final class HomeViewModelTests: XCTestCase {
    func test_weather_API_success() {
        let mockWeatherService = MockWeatherService(result: .success(getHomeModel()))
        let mockDownloadImageService = MockDownloadImageService(result: .failure(NetworkError.apiError))
        let sut = HomeViewModel(weatherService: mockWeatherService,
                                homeCoordinator: HomeCoordinator(navigationController: UINavigationController()),
                                userDefaultManage: MockUserDefaults(),
                                downloadImageService: mockDownloadImageService)
        sut.fetchCurrentWeather()
        sut.completion = {
            XCTAssertNotNil(sut.homeModel)
            XCTAssertEqual(sut.homeModel?.placeName, "Pune")
        }
    }
    
    func test_weather_API_failure() {
        let mockWeatherService = MockWeatherService(result: .failure(NetworkError.apiError))
        let mockDownloadImageService = MockDownloadImageService(result: .failure(NetworkError.apiError))
        let sut = HomeViewModel(weatherService: mockWeatherService,
                                homeCoordinator: HomeCoordinator(navigationController: UINavigationController()),
                                userDefaultManage: MockUserDefaults(),
                                downloadImageService: mockDownloadImageService)
        sut.fetchCurrentWeather()
        sut.completion = {
            XCTAssertNil(sut.homeModel)
        }
    }
    
    func test_download_image_API_success() {
        let mockWeatherService = MockWeatherService(result: .success(getHomeModel()))
        let mockDownloadImageService = MockDownloadImageService(result: .success(WeatherIconModel(icon: UIImage())))
        let sut = HomeViewModel(weatherService: mockWeatherService,
                                homeCoordinator: HomeCoordinator(navigationController: UINavigationController()),
                                userDefaultManage: MockUserDefaults(),
                                downloadImageService: mockDownloadImageService)
        sut.getWeatherIcon(name: "02D")
        sut.completion = {
            XCTAssertNotNil(sut.weatherIcon)
        }
    }
    
    func test_download_image_API_failure() {
        let mockWeatherService = MockWeatherService(result: .success(getHomeModel()))
        let mockDownloadImageService = MockDownloadImageService(result: .failure(NetworkError.apiError))
        let sut = HomeViewModel(weatherService: mockWeatherService,
                                homeCoordinator: HomeCoordinator(navigationController: UINavigationController()),
                                userDefaultManage: MockUserDefaults(),
                                downloadImageService: mockDownloadImageService)
        sut.getWeatherIcon(name: "02D")
        sut.completion = {
            XCTAssertNil(sut.weatherIcon)
        }
    }
    
    
    func getHomeModel() -> HomeModel {
        HomeModel(placeName: "Pune",
                  temperature: 31.2,
                  weatherIcon: "",
                  pressure: 44.0,
                  humidity: 0.0,
                  environment: "",
                  windSpeed: 100.9,
                  sunrise: 0.0,
                  sunset: 0.0)
    }
}
                                                    
                                                    
