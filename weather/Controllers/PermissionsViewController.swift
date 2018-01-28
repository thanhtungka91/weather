//
//  PermissionsViewController.swift
//  weather
//
//  Created by Vo Thanh Tung on 1/28/18.
//  Copyright © 2018 Vo Thanh Tung. All rights reserved.
//

import UIKit
import CoreLocation

class PermissionsViewController: UIViewController {
    //implement view permission here
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var messagePermissionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // location manager setup
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
//        myImage.translatesAutoresizingMaskIntoConstraints = false
//        myImage.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//        self.view.addSubview(myImage)
//
//        let topConstraint = myImage.topAnchor.constraint(equalTo: self.view.topAnchor)
//        let bottomConstraint = myImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        let leftConstraint = myImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
//        let rightConstraint = myImage.rightAnchor.constraint(equalTo: self.view.rightAnchor)
//
//        imageConstraints = [topConstraint, bottomConstraint, leftConstraint, rightConstraint]
//        NSLayoutConstraint.activate(imageConstraints)
    }
    // action for accept location permissions
    
    @IBAction func askForLocationPermissions(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                // The user has not yet made a choice regarding whether this app can use location services, then request permissions to use Location on foreground
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                self.displayLocationPermissionsDenied()
                // show alert
                let alert = UIAlertController(title: "Alert", message: Constants.ACTIVE_LOCATION_PERMISSIONS, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .authorizedAlways, .authorizedWhenInUse:
                self.authorizationCompleted()
            }
        } else {
            // Location services are not enabled
            self.displayLocationPermissionsDenied()
        }
    }
    
    func displayLocationPermissionsDenied() {
        self.messagePermissionLabel.text = Constants.MESSAGE_DENIED_LOCATION_PERMISSIONS
    }
    
    func authorizationCompleted() {
        dismiss(animated: true)
    }
    
    // for extend of extension
    func manageLocationStatus(status: CLAuthorizationStatus) {
        switch(status) {
        case .notDetermined:
            self.displayLocationPermissionsNotDeterminated()
        case .restricted, .denied:
            self.displayLocationPermissionsDenied()
        case .authorizedAlways, .authorizedWhenInUse:
            self.authorizationCompleted()
        }
    }

    func displayLocationPermissionsNotDeterminated() {
        self.messagePermissionLabel.text = Constants.MESSAGE_REQUEST_LOCATION_PERMISSIONS
    }
    
}

extension PermissionsViewController: CLLocationManagerDelegate {
    // the authorization status for the application changed
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus){
        self.manageLocationStatus(status: status)
    }
}
