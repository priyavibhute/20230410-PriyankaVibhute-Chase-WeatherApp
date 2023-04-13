//
//  TimeConverter.swift
//  WeatherApp
//
//  Created by Priyanka Vibhute on 12/04/23.
//

import Foundation
func stringTimeFromUnix(value: Double?) -> String {
    var time = ""
    if let unixDate = value {
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "en_US")
        time = dateFormatter.string(from: date)
    }
    return time
}
