//
//  RoundUpDouble.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 12/04/23.
//

import Foundation
func roundUpDouble(value: Double) -> String {
    return String(format: "%0.3f", (Double(round(1000 * value) / 1000)))
}
