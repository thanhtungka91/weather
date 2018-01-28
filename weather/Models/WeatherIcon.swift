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
    
    init(iconString: String) {
        switch iconString {
        case "01d": self = .clearSky
        case "02d": self = .fewClouds
        case "03d": self = .scatteredClouds
        case "04d": self = .brokenClouds
        case "09d": self = .showerRain
        case "10d": self = .rain
        case "11d": self = .thunderstorm
        case "13d": self = .snow
        case "50d": self = .mist
        default: self = .default
        }
    }
}

extension WeatherIcon {
    var image: UIImage {
        switch self {
        case .clearSky: return #imageLiteral(resourceName: "sun")
        case .fewClouds: return #imageLiteral(resourceName: "winspeed")
        case .scatteredClouds: return #imageLiteral(resourceName: "sun")
        case .brokenClouds: return #imageLiteral(resourceName: "sun")
        case .showerRain: return #imageLiteral(resourceName: "sun")
        case .rain: return #imageLiteral(resourceName: "sun")
        case .thunderstorm: return #imageLiteral(resourceName: "sun")
        case .snow: return #imageLiteral(resourceName: "sun")
        case .mist: return #imageLiteral(resourceName: "sun")
        case .default: return #imageLiteral(resourceName: "sun")
        }
    }
    
}
