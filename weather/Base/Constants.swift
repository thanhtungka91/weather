//
//  Constants.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/28/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import Foundation
import Foundation

class Constants {
    // MARK: FirebaseDBProvider - weathers reference
    
    static let WEATHER = "weathers"
    
    // weathers reference properties
    static let WEATHER_CITY = "city"
    static let WEATHER_TEMP = "temperature"
    static let WEATHER_CONDITION = "condition"
    static let DATE = "date"
    static let LATITUDE = "lat"
    static let LONGITUDE = "lon"
    
    // MARK: - Segues
    
    static let REQUEST_PERMISSIONS_SEGUE_ID = "RequestPermissions"
    static let FORECAST_CELL_SEGUE_ID = "ForecastCell"
    
    // MARK: API
    
    static let API_BASE_URL = "https://api.openweathermap.org/data/2.5/"
    static let API_ENDPOINT_CURRENT_WEATHER = "weather/"
    static let API_ENDPOINT_FORECAST_WEATHER = "forecast/"
    
    // MARK: Messages
    
    static let MESSAGE_REQUEST_LOCATION_PERMISSIONS = "Would you like to know the weather in your city? Then allow us know where you are :)"
    static let MESSAGE_DENIED_LOCATION_PERMISSIONS = "You have denied us the location permissions. Please activate them in the Settings of your device to continue."
    static let ACTIVE_LOCATION_PERMISSIONS = "Please activate your location: Settings > Weather Today > Location > While Using the App"
    
    
    
}
