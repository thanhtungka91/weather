//
//  OpenWeatherMapError.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/28/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import Foundation

enum OpenWeatherMapError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidaData
    case jsonConversionFailure
    case invalidUrl
    case jsonParsingFailure
}
