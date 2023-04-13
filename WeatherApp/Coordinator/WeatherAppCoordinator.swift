//
//  WeatherAppCoordinator.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation
import UIKit

protocol WeatherAppCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class WeatherAppCoordinator: WeatherAppCoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(with _navigationController: UINavigationController) {
        self.navigationController = _navigationController
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}
