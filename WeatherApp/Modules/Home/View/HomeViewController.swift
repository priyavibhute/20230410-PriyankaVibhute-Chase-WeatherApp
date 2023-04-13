//
//  ViewController.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CoordinatorBoard {
    
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temprature: UILabel!
    @IBOutlet weak var environment: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    var viewModel: HomeViewModel?
    
    let locationManager = CLLocationManager()
    // Use Localisations for strings
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
        // Do any additional setup after loading the view.
    }
    
    func getUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool)  {
        navigationController?.navigationBar.isHidden = true
        setUpView()
    }
    
    func setUpView()  {
        viewModel?.fetchCurrentWeather()
    }
    
    @IBAction func searchLocation(_ sender: Any) {
        viewModel?.launchSearchViewController()
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func updateWeatherComponents() {
        self.cityName.text = self.viewModel?.homeModel?.placeName
        self.temprature.text = self.viewModel?.homeModel?.temperature.degree()
        self.pressure.text = roundUpDouble(value: self.viewModel?.homeModel?.pressure ?? 0.0)
        self.wind.text = roundUpDouble(value: self.viewModel?.homeModel?.windSpeed ?? 0.0)
        self.humidity.text = roundUpDouble(value: self.viewModel?.homeModel?.humidity ?? 0.0)
        self.environment.text = self.viewModel?.homeModel?.environment
        self.sunrise.text = stringTimeFromUnix(value: self.viewModel?.homeModel?.sunrise)
        self.sunset.text = stringTimeFromUnix(value: self.viewModel?.homeModel?.sunset)
    }
    
    func updateIcon() {
        self.weatherIcon.image = self.viewModel?.weatherIcon?.icon
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

