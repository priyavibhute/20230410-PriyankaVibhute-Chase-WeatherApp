//
//  UserDefaultManager.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 11/04/23.
//
import Foundation

protocol UserDefaultManagerProtocol {
    func save(city: City)
    func getCity() -> City
}

class UserDefaultManager: UserDefaultManagerProtocol {
    let userDefault: UserDefaults
    
    init(userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
    
    func save(city: City) {
        //Use constants for keys
        let jsonEncoder = JSONEncoder()
        if let encoded = try? jsonEncoder.encode(city) {
            userDefault.set(encoded, forKey: "CurrentCity")
        }
    }
    
    func getCity() -> City {
        if let city = userDefault.object(forKey: "CurrentCity") as? Data {
            let decoder = JSONDecoder()
            if let city = try? decoder.decode(City.self, from: city) {
                return city
            }
        }
        return City(name: "Pune", lat: 18.5204, lon: 73.8567)
    }
}

