//
//  ServiceLayer.swift
//  IotBlue
//
//  Created by Sierra on 6/20/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit


class ServiceLayer {
    
     func getWeatherData(lat:Double, lon:Double, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&APPID=f9f89e3f8df9497aef7f3556f912f872" as? String else {return}
        
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: completion).resume()
    }
}
