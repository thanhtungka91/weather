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
    
    // for declear layout
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windspeed: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherCondtion: UILabel!
    
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
//                    FirebaseDBProvider.Instance.saveCurrentWeather(currentWeather: currentWeatherViewModel)
                    // save current weather to realm
//                    RealmDBProvider.Instance.saveCurrentWeather(currentWeather:currentWeatherViewModel)
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
        
        self.cityName.text = viewModel.cityName
        self.temperature.text = viewModel.temperature
        self.weatherCondtion.text = viewModel.weatherCondition
        self.humidity.text = viewModel.humidity
//        self.precipitationLabel.text = viewModel.precipitationProbability
        self.pressure.text = viewModel.pressure
        self.windspeed.text = viewModel.windSpeed
//        self.windDirectionLabel.text = viewModel.windDirection
        self.weatherImage.image = viewModel.icon
    }
    
    @IBAction func tapShareButton(_ sender: Any) {
        let sharedText = "\(currentWeatherViewModel.cityName!.uppercased())'s temperature ---> \(currentWeatherViewModel.temperature!)"
        let activityController = UIActivityViewController(activityItems: [sharedText, currentWeatherViewModel.icon!], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
}




