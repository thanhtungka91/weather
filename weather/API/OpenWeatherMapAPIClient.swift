//
//  OpenWeatherMapAPIClient.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/23/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import Foundation
import Alamofire

class OpenWeatherMapAPIClient {
    static let client = OpenWeatherMapAPIClient()
    
    fileprivate let apiKey = "fc1036c4b44f34b5932deaf7c729439f"
    
    lazy var baseUrl: URL = {
        return URL(string: Constants.API_BASE_URL)!
    }()
    
    
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, OpenWeatherMapError?) -> Void
    typealias ForecastWeatherCompletionHandler = ([ForecastWeather]?, OpenWeatherMapError?) -> Void
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        
        guard let url = URL(string: Constants.API_ENDPOINT_CURRENT_WEATHER, relativeTo: baseUrl) else {
            completion(nil, .invalidUrl)
            return
        }
        
        let parameters: Parameters = self.buildParameters(coordinate: coordinate)
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            guard let JSON = response.result.value as? Dictionary<String, AnyObject> else {
                completion(nil, .invalidaData)
                return
            }
            
            if response.response?.statusCode == 200 {
                guard let currentWeather = CurrentWeather(json: JSON) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }
                
                completion(currentWeather, nil)
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
    }
    
    func getForecastWeather(at coordinate: Coordinate, completionHandler completion: @escaping ForecastWeatherCompletionHandler) {
        
        guard let url = URL(string: Constants.API_ENDPOINT_FORECAST_WEATHER, relativeTo: baseUrl) else {
            completion(nil, .invalidUrl)
            return
        }
        
        let parameters: Parameters = self.buildParameters(coordinate: coordinate)
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            guard let JSON = response.result.value else {
                completion(nil, .invalidaData)
                return
            }
            
            if response.response?.statusCode == 200 {
                var forecasts: [ForecastWeather] = []
                
                if let dict = JSON as? Dictionary<String, AnyObject>{
                    if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                        for obj in list {
                            let forecast = ForecastWeather(json: obj)
                            forecasts.append(forecast!)
                        }
                    }
                }
                
                completion(forecasts, nil)
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
    }
    
    func buildParameters(coordinate: Coordinate) -> Parameters {
        let parameters: Parameters = [
            "appid": self.apiKey,
            "units": "metric",
            "lat": String(coordinate.latitude),
            "lon": String(coordinate.longitude)
        ]
        
        return parameters
    }
}
