//
//  ViewController.swift
//  Kitsch
//
//  Created by Ben Ashman on 1/19/16.
//  Copyright © 2016 Ben Ashman. All rights reserved.
//

import UIKit
import ForecastIO

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var weatherSummaryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Forecast client
        let keyPath = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")!
        let keyDictionary = NSDictionary(contentsOfFile: keyPath)!
        let forecastAPIKey = keyDictionary.objectForKey("ForecastIOAPIKey") as! String
        
        let forecastClient = APIClient(apiKey: forecastAPIKey)
        forecastClient.units = .UK
        
        let lat = 37.7756899
        let lng = -122.4189387
        
        forecastClient.getForecast(latitude: lat, longitude: lng, completion: { (forecast, error) -> Void in
            if let forecast = forecast {
                let currentWeather = forecast.currently!
                let temperature = Int(currentWeather.temperature!)
                let summary = currentWeather.summary!
            
                dispatch_async(dispatch_get_main_queue()) {
                    self.weatherTempLabel.text = "\(temperature)° in San Francisco"
                    self.weatherSummaryLabel.text = summary
                }
            } else if let error = error {
                print(error)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

