//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation

class SearchViewModel {
    
    private let locationService: LocationServiceProtocol?
    let searchCoordinator: SearchCoordinator?
    var cities: [City] = []
    
    init(locationService: LocationServiceProtocol?,
         searchCoordinator: SearchCoordinator) {
        self.locationService = locationService
        self.searchCoordinator = searchCoordinator
    }
    
    func searchLocation(text: String, onCompletion: @escaping (Result<Bool, NetworkError>) -> Void) {
        locationService?.searchLocation(searchText: text,
                                        limit: 15,
                                        completion: {[weak self] result in
            switch result {
            case .success(let response):
                self?.cities.removeAll()
                self?.cities.append(contentsOf: response.cities)
                if response.cities.count > 0 {
                    onCompletion(.success(true))
                } else {
                    onCompletion(.success(false))
                }
            case .failure(let error):
                // Need to show Error Popup on UI to handle this error but due to time constraint could't cover in this assignment.
                onCompletion(.failure(error))
            }
        })
    }
}

