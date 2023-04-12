//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol{
    func launchSearchViewController()
    func fetchSelectedWeatherData(city: City)
}

class HomeCoordinator: WeatherAppCoordinatorProtocol {
    var navigationController: UINavigationController
    var viewModel: HomeViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController.launchFromStoryBoard()
        viewModel = HomeViewModel(weatherService: WeatherService(),
                                  homeCoordinator: self,
                                  userDefaultManage: UserDefaultManager(),
                                  downloadImageService: DownloadImageService())
        viewModel?.delegate = homeViewController
        homeViewController.viewModel = viewModel
        self.navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func launchSearchViewController() {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController, parentView: self)
        searchCoordinator.start()
    }
    
    func fetchSelectedWeatherData(city: City) {
        viewModel?.selectedCity = city
    }
}
