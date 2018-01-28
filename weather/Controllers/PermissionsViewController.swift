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
}
