//
//  Double+Extenstion.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 11/04/23.
//

import Foundation
extension Double {
    func degree() -> String {
        let value = String(format: "%.1f", self)
        return "\(value)°"
    }
}
