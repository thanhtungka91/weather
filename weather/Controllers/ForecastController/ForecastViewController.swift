//
//  ForecastViewController.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/28/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    // initial layout
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
//
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation!
    var forecastWeatherViewModels: [ForecastWeatherViewModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("swit log simple more than objective C")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkPermissions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkPermissions() {
        Coordinate.checkForGrantedLocationPermissions() { [unowned self] allowed in
            if allowed {
//                self.locationManager.requestLocation()
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
    
    func toggleRefreshAnimation(on: Bool) {
        if on {
            indicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            indicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    
}

