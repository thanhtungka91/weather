//
//  WeatherTodayViewController.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/28/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import UIKit
import CoreLocation

// create model
var currentWeatherViewModel: CurrentWeatherViewModel!

class WeatherTodayViewController: UIViewController, CLLocationManagerDelegate {
    //implement controller here
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today"
        
        //set up location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()

        setupActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkPermissions()
    }
    
    //set up indicator when waiting for the response of api
    
    func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
    func checkPermissions() {
        
        // go to Coordinate to get the location
        Coordinate.checkForGrantedLocationPermissions() { [unowned self] allowed in
            if allowed {
//                self.locationManager.requestLocation()
                self.getCurrentWeather()
            } else {
                self.showPermissionsScreen()
            }
        }
    }
    
    // call to api and get the value, update to the view
    
    func getCurrentWeather() {
        toggleRefreshAnimation(on: true)
        DispatchQueue.main.async {
            OpenWeatherMapAPIClient.client.getCurrentWeather(at: Coordinate.sharedInstance) {
                [unowned self] currentWeather, error in
                if let currentWeather = currentWeather {
                    currentWeatherViewModel = CurrentWeatherViewModel(model: currentWeather)
                    // update UI
                    self.displayWeather(using: currentWeatherViewModel)
                    // save weather
                    FirebaseDBProvider.Instance.saveCurrentWeather(currentWeather: currentWeatherViewModel)
                    self.toggleRefreshAnimation(on: false)
                }
            }
        }
    }
    
    func showPermissionsScreen() {
        //REQUEST_PERMISSIONS_SEGUE_ID = "RequestPermissions"
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.REQUEST_PERMISSIONS_SEGUE_ID) {
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
    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        //set up view value
        
//        self.cityNameLabel.text = viewModel.cityName
//        self.temperatureLabel.text = viewModel.temperature
//        self.weatherConditionLabel.text = viewModel.weatherCondition
//        self.humidityLabel.text = viewModel.humidity
//        self.precipitationLabel.text = viewModel.precipitationProbability
//        self.pressureLabel.text = viewModel.pressure
//        self.windSpeedLabel.text = viewModel.windSpeed
//        self.windDirectionLabel.text = viewModel.windDirection
//        self.weatherImageView.image = viewModel.icon
    }
    
}
//extension ViewController : CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("error:: \(error.localizedDescription)")
//    }
//
//    func locationManager2(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            self.locationManager.requestLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if locations.first != nil {
//            print("location:: (location)")
//        }
//
//    }
//
//}




