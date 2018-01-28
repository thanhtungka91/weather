//
//  WeatherIcon.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/28/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import Foundation
import UIKit

enum WeatherIcon {
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case snow
    case mist
    case `default`
    
    // for detail what is the code
    //https://openweathermap.org/weather-conditions
    init(iconString: String) {
        switch iconString {
            //days
        case "01d": self = .clearSky
        case "02d": self = .fewClouds
        case "03d": self = .scatteredClouds
        case "04d": self = .brokenClouds
        case "09d": self = .showerRain
        case "10d": self = .rain
        case "11d": self = .thunderstorm
        case "13d": self = .snow
        case "50d": self = .mist
            //night
        case "01n": self = .clearSky
        case "02n": self = .fewClouds
        case "03n": self = .scatteredClouds
        case "04n": self = .brokenClouds
        case "09n": self = .showerRain
        case "10n": self = .rain
        case "11n": self = .thunderstorm
        case "13n": self = .snow
        case "50n": self = .mist
            
        default: self = .default
        }
    }
}

extension WeatherIcon {
    var image: UIImage {
        switch self {
        case .clearSky: return #imageLiteral(resourceName: "clearsky")
        case .fewClouds: return #imageLiteral(resourceName: "winspeed")
        case .scatteredClouds: return #imageLiteral(resourceName: "sun")
        case .brokenClouds: return #imageLiteral(resourceName: "cloud")
        case .showerRain: return #imageLiteral(resourceName: "showerRain")
        case .rain: return #imageLiteral(resourceName: "rains")
        case .thunderstorm: return #imageLiteral(resourceName: "thunderstorm")
        case .snow: return #imageLiteral(resourceName: "snowflake")
        case .mist: return #imageLiteral(resourceName: "mist")
        case .default: return #imageLiteral(resourceName: "clearsky")
        }
    }
    
}
