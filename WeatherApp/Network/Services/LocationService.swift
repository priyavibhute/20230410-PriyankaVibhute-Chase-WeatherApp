//
//  GeoCodingService.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation

protocol LocationServiceProtocol {
    func searchLocation(searchText: String,
                        limit: Int,
                        completion: @escaping (Result<SearchDataModel, NetworkError>) -> Void)
}

class LocationService: BaseService, LocationServiceProtocol {
    
    func searchLocation(searchText: String,
                        limit: Int,
                        completion: @escaping (Result<SearchDataModel, NetworkError>) -> Void) {
        
        guard let url = URL(string: locationBaseURL + "direct?q=\(searchText)&limit=\(limit)&appid=\(key)") else {
            completion(.failure(.apiError))
            return
        }
        
        apiService.request(url: url,
                           type: [City].self) { [self] result in
            switch result {
            case .success(let locationData):
                completion(.success(getLocationData(city: locationData)))
                
            case .failure(_):
                completion(.failure(.apiError))
            }
        }
    }
    
    func getLocationData(city: [City]) -> SearchDataModel {
        return SearchDataModel(cities: city)
        
    }
}

