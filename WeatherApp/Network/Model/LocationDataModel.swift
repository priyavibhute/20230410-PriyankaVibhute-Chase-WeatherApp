//
//  LocationDataModel.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation

struct LocationDataModel: Codable {
    var cities: [City]
}

struct City: Codable {
    var name: String
    var lat: Double
    var lon: Double
    var country: String?
    var state: String?
    var local_names: [String: String]?
}
