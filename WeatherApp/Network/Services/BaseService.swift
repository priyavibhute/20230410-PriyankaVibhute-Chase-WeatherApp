//
//  BaseService.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation

class BaseService {
    let key = "33f892d964e11154a771d243fc25f14a"
    let weatherBaseURL = "https://api.openweathermap.org/data/2.5/"
    let iconBaseURL = "https://openweathermap.org/img/wn/"
    let locationBaseURL = "https://api.openweathermap.org/geo/1.0/"
    
    let urlSession: URLSession
    let apiService: APIService
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
        apiService = APIService()
    }
}
