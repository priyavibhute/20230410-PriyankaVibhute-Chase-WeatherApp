//
//  Weather.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation

struct CurrentWeather: Codable {
    var coord: Coordinates?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var clouds: Cloud?
    var dt: Int?
    var sys: System?
    var timezone: Int?
    var id: Int?
    var name: String?
    var cod: Int?
    var wind: Wind?
}

struct Coordinates: Codable {
    var lon: Double?
    var lat: Double?
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var humidity: Double?
    var sea_level: Int?
    var grnd_level: Int?
    
}

struct Wind: Codable {
    var speed: Double?
    var deg: Double?
    var gust: Double?
}

struct Cloud: Codable {
    var all: Int?
}

struct System: Codable {
    var country: String?
    var sunrise: Double?
    var sunset: Double?
}

