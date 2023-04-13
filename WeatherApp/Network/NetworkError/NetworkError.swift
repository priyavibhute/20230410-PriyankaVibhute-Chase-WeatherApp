//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 10/04/23.
//

import Foundation
enum NetworkError: Error {
    case apiError
    case decodingError
    case badRequest
}
