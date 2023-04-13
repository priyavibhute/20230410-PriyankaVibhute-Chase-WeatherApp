//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation
import UIKit

protocol SearchCoordinatorProtocol {
    func selectedCity(city: City)
}

class SearchCoordinator: WeatherAppCoordinatorProtocol, SearchCoordinatorProtocol {
    var navigationController: UINavigationController
    var parentView: WeatherAppCoordinatorProtocol?
    
    init(navigationController: UINavigationController, parentView: WeatherAppCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentView = parentView
    }
    
    func start() {
        let searchViewController = SearchViewController.launchFromStoryBoard()
        searchViewController.viewModel = SearchViewModel(locationService: LocationService(), searchCoordinator: self)
        self.navigationController.pushViewController(searchViewController, animated: false)
    }
    
    func selectedCity(city: City) {
        if let homeCoordinator = parentView as? HomeCoordinator {
            homeCoordinator.fetchSelectedWeatherData(city: city)
            navigationController.popViewController(animated: true)
        }
    }
}
