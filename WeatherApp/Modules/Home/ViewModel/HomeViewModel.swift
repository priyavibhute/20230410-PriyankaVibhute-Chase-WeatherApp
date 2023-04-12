//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation

protocol HomeViewProtocol: NSObject {
    func updateWeatherComponents()
    func updateIcon()
}

class HomeViewModel {
    
    private let weatherService: WeatherServiceProtocol?
    private let downloadImageService: DownloadImageServiceProtocol?
    private let userDefaultManage :UserDefaultManagerProtocol?
    let homeCoordinator: HomeCoordinator?
    var currentCoordinate: Coordinates?
    var selectedCity: City?
    var weatherIcon: WeatherIconModel?
    @Published var homeModel: HomeModel?
    weak var delegate: HomeViewProtocol?
    var completion: (() -> ())?
    
    init(weatherService: WeatherServiceProtocol,
         homeCoordinator: HomeCoordinator,
         userDefaultManage: UserDefaultManagerProtocol,
         downloadImageService: DownloadImageServiceProtocol) {
        self.weatherService = weatherService
        self.homeCoordinator = homeCoordinator
        self.userDefaultManage = userDefaultManage
        self.downloadImageService = downloadImageService
    }
    
    func launchSearchViewController() {
        homeCoordinator?.launchSearchViewController()
    }
    
    private func fetchWeatherWithCoordinates() {
        //Refactor This Code
        if let _ = selectedCity {
        } else {
            selectedCity = userDefaultManage?.getCity()
        }
    }
    
    func updateSelectedCity(city: City) {
        selectedCity = city
    }
    
    func fetchCurrentWeather() {
        fetchWeatherWithCoordinates()
        if let selectedCity = selectedCity {
            weatherService?.getWeatherData(latitude: selectedCity.lat,
                                           longitude: selectedCity.lon,
                                           completion: { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        if let selectedCity = self?.selectedCity {
                            self?.userDefaultManage?.save(city: selectedCity)
                        }
                        self?.homeModel = data
                        self?.getWeatherIcon(name: data.weatherIcon)
                        self?.delegate?.updateWeatherComponents()
                        self?.completion?()
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        //Need to show Error Popup on UI to handle this error but due to time constraint could't cover in this assignment.
                        self?.completion?()
                    }
                }
            })
        }
    }
    
    func getWeatherIcon(name: String) {
        downloadImageService?.getImage(name: name, completion: { [weak self] result in
            switch result {
            case .success(let weatherIconData):
                DispatchQueue.main.async {
                    self?.weatherIcon = weatherIconData
                    self?.delegate?.updateIcon()
                    self?.completion?()
                }
            case .failure(let error):
                //Need to show Error Popup on UI to handle this error but due to time constraint could't cover in this assignment.
                self?.completion?()
                print(error)
            }
        })
    }
}
