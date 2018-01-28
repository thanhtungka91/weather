//
//  ForecastViewController.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/28/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var forecastWeatherViewModels: [ForecastWeatherViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currentWeatherViewModel.cityName
        
        // location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //set high cell
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkPermissions()
    }
    
    func checkPermissions() {
        Coordinate.checkForGrantedLocationPermissions() { [unowned self] allowed in
            if allowed {
                self.locationManager.requestLocation()
                self.getForecastWeather()
            } else {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.REQUEST_PERMISSIONS_SEGUE_ID) {
                    self.navigationController?.present(vc, animated: true)
                }
            }
        }
    }
    
    func getForecastWeather() {
        toggleRefreshAnimation(on: true)
        DispatchQueue.main.async {
            OpenWeatherMapAPIClient.client.getForecastWeather(at: Coordinate.sharedInstance) {
                [unowned self] forecastsWeather, error in
                if let forecastsWeather = forecastsWeather {
                    // reset self.forecastWeatherViewModels to avoid repeat items
                    if forecastsWeather.count > 0 {
                        self.forecastWeatherViewModels = []
                    }
                    
                    for forecastWeather in forecastsWeather {
                        let forecastWeatherVM = ForecastWeatherViewModel(model: forecastWeather)
                        self.forecastWeatherViewModels.append(forecastWeatherVM)
                    }
                    
                    self.tableView.reloadData()
                    self.toggleRefreshAnimation(on: false)
                }
            }
        }
    }
    
    func showPermissionsScreen() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.REQUEST_PERMISSIONS_SEGUE_ID) {
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    func toggleRefreshAnimation(on: Bool) {
        if on {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastWeatherViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastWeatherVM = self.forecastWeatherViewModels[indexPath.row]
        
        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORECAST_CELL_SEGUE_ID, for: indexPath) as! ForecastDayTableViewCell
        
        // Configure Cell
        cell.weatherConditionImageView.image = forecastWeatherVM.icon
        cell.weekdayLabel.text = forecastWeatherVM.weekday
        cell.weatherConditionLabel.text = forecastWeatherVM.weatherCondition
        cell.temperatureLabel.text = forecastWeatherVM.temperature
        
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0 
    }
}

extension ForecastViewController: CLLocationManagerDelegate {
    // new location data is available
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // update shaped instance
        Coordinate.sharedInstance.latitude = (manager.location?.coordinate.latitude)!
        Coordinate.sharedInstance.longitude = (manager.location?.coordinate.longitude)!
        // request forecast weather
        self.getForecastWeather()
    }
    
    // the location manager was unable to retrieve a location value
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        Coordinate.checkForGrantedLocationPermissions() { allowed in
            if !allowed {
                self.showPermissionsScreen()
            }
        }
    }
}
