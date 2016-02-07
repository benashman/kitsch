//
//  ViewController.swift
//  Kitsch
//
//  Created by Ben Ashman on 1/19/16.
//  Copyright © 2016 Ben Ashman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import ForecastIO

class DashboardViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var weatherSummaryLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request location
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func getForecastForLocation(lat: Double, lng: Double) {
        let keyPath = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")!
        let keyDictionary = NSDictionary(contentsOfFile: keyPath)!
        let forecastAPIKey = keyDictionary.objectForKey("ForecastIOAPIKey") as! String
        
        let forecastClient = APIClient(apiKey: forecastAPIKey)
        forecastClient.units = .UK
        
        let location = CLLocation(latitude: lat, longitude: lng)
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            let placemark = placemarks![0]
            let cityName = placemark.addressDictionary!["City"] as! String
            
            forecastClient.getForecast(latitude: lat, longitude: lng, completion: { (forecast, error) -> Void in
                if let forecast = forecast {
                    let currentWeather = forecast.currently!
                    let temperature = Int(currentWeather.temperature!)
                    let summary = currentWeather.summary!
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.weatherTempLabel.text = "\(temperature)° in \(cityName)"
                        self.weatherSummaryLabel.text = summary
                    }
                } else if let error = error {
                    print(error)
                }
            })
        })
    }

    // MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates = manager.location!.coordinate
        self.getForecastForLocation(coordinates.latitude, lng: coordinates.longitude)
        
        locationManager.stopUpdatingLocation()
    }
}

