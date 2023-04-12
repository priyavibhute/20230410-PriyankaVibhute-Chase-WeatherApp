//
//  BaseService.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation

enum AppServices {
    case locationSearch
    case weatherData
    case imageData
}

extension AppServices {
    var path: String {
        switch self {
        case .locationSearch:
            return "/geo/1.0/direct"
        case .weatherData:
            return "/data/2.5/weather"
        case .imageData:
            return "/img/wn/"
        }
    }
    
    // We can add more request data here.
}

class BaseService {
    let key = "33f892d964e11154a771d243fc25f14a"
    let baseURL = "https://api.openweathermap.org"
    let iconBaseURL = "https://openweathermap.org"
    
    let urlSession: URLSession
    let apiService: APIService
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
        apiService = APIService()
    }
}
