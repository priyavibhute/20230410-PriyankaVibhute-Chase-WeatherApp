//
//  WeatherServiceRepository.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeatherData(latitude: Double,
                        longitude: Double,
                        completion: @escaping (Result<HomeModel, NetworkError>) -> Void)
}

//Added this layer to keep higher level modules independent of lower level modules

class WeatherService: BaseService, WeatherServiceProtocol {
    var homeModel: HomeModel?
    let appService = AppServices.weatherData
    func getWeatherData(latitude: Double,
                        longitude: Double,
                        completion: @escaping (Result<HomeModel, NetworkError>) -> Void) {
        // We can use here URLComponents and take foloowing fields as parameters. 
        guard let url = URL(string: baseURL + appService.path + "?lat=\(latitude)&lon=\(longitude)&appid=\(key)&units=metric") else {
            completion(.failure(.apiError))
            return
        }
        
        apiService.request(url: url,
                           type: CurrentWeather.self) { result in
            switch result {
            case .success(let weatherData):
                self.getHomeModal(currentWeather: weatherData)
                guard let homeModel = self.homeModel else {
                    completion(.failure(.apiError))
                    return
                }
                completion(.success(homeModel))
                
            case .failure(_):
                completion(.failure(.apiError))
            }
        }
    }
    
    func getHomeModal(currentWeather: CurrentWeather) {
        if let name = currentWeather.name,
           let weather = currentWeather.weather, weather.count > 0,
           let wind = currentWeather.wind,
           let main = currentWeather.main {
            homeModel =  HomeModel(placeName: name,
                                   temperature: main.temp ?? 0.0,
                                   weatherIcon: weather[0].icon ?? "",
                                   pressure: main.pressure ?? 0.0,
                                   humidity: main.humidity ?? 0.0,
                                   environment: weather[0].main ?? "",
                                   windSpeed: wind.speed ?? 0.0,
                                   sunrise: currentWeather.sys?.sunrise ?? 0.0,
                                   sunset: currentWeather.sys?.sunset ?? 0.0)
        }
    }
}
