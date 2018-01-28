//
//  CurrentWeatherViewModel.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/28/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import Foundation

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    var cityName: String?
    var temperature: String?
    var weatherCondition: String?
    var humidity: String?
    var precipitationProbability: String?
    var pressure: String?
    var windSpeed: String?
    var windDeg: Double?
    var windDirection: String?
    var icon: UIImage?
    
    init(model: CurrentWeather) {
        self.cityName = model.cityName
        self.weatherCondition = model.weatherCondition
        
        self.temperature = CurrentWeatherViewModel.formatValue(value: model.temperature, endStringWith: "°")
        
        
        self.humidity = CurrentWeatherViewModel.formatValue(value: model.humidity, endStringWith: "%")
        
        self.precipitationProbability = CurrentWeatherViewModel.formatValue(value: model.precipitationProbability, endStringWith: " mm", castToInt: false)
        
        self.pressure = CurrentWeatherViewModel.formatValue(value: model.pressure, endStringWith: " hPa")
        
        self.windSpeed = CurrentWeatherViewModel.formatValue(value: model.windSpeed, endStringWith: " km/h")
        
        self.windDeg = model.windDeg
        
        self.windDirection = "NE"
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
    }
    
    static func formatValue(value: Double, endStringWith: String = "", castToInt: Bool = true) -> String {
        var returnValue: String
        let defaultString = "-"
        
        if value == Double.infinity {
            returnValue = defaultString
        } else if castToInt {
            returnValue = "\(Int(value))"
        } else {
            returnValue = "\(value)"
        }
        
        return returnValue.appending(endStringWith)
    }
}
