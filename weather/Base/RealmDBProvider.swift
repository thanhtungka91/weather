//
//  RealmDBProvider.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/29/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDBProvider{
    
    //initial class- > provide for using method from controller
    private static let _instance = RealmDBProvider()
    
    static var Instance: RealmDBProvider{
        return _instance
    }
    
    final class CurrentWeather: Object {
        @objc dynamic var cityName = ""
        @objc dynamic var temperature = ""
        @objc dynamic var weatherCondition = ""
        @objc dynamic var lon = ""
        @objc dynamic var lat = ""
        @objc dynamic var id = ""
        
        
        override static func primaryKey() -> String? {
            return "id"
        }
    }
   
    func saveCurrentWeather(currentWeather: CurrentWeatherViewModel) {
        let uuid = UUID().uuidString
        var  currentWeatherVarible: CurrentWeather
        
        let data: Dictionary<String, Any> = [
            Constants.WEATHER_CITY: currentWeather.cityName!,
            Constants.WEATHER_TEMP: currentWeather.temperature!,
            Constants.WEATHER_CONDITION: currentWeather.weatherCondition!,
            Constants.DATE: self.getCurrentDate(),
            Constants.LATITUDE: String(Coordinate.sharedInstance.latitude),
            Constants.LONGITUDE: String(Coordinate.sharedInstance.longitude)
        ]
        
        //insert to realm db
//        currentWeatherVarible.insert()
        
        
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let currentDate = formatter.string(from: date)
        
        return currentDate
    }

    
}
