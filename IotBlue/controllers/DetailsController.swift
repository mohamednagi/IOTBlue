//
//  DetailsController.swift
//  IotBlue
//
//  Created by Sierra on 6/20/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit

class DetailsController: NSObject {

    var detailsView = DetailsView()
    let remote = ServiceLayer()
    
    func getData(lat:Double, lon:Double) {
        print(lat)
        print(lon)
        remote.getWeatherData(lat: lat, lon: lon) { (data, response, error) in
            if error == nil && data != nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] else {return}
                    guard let name = json["name"] as? String else {return}
                    guard let clouds = json["clouds"] as? [String:AnyObject] else {return}
                    guard let rain = clouds["all"] as? Double else {return}
                    guard let mainInfo = json["main"] as? [String:AnyObject] else {return}
                    guard let tempreture = mainInfo["temp"] as? Double else {return}
                    guard let humidity = mainInfo["humidity"] as? Double else {return}
                    guard let wind = json["wind"] as? [String:AnyObject] else {return}
                    guard let windSpeed = wind["speed"] as? Double else {return}
                    DispatchQueue.main.async {
                        self.detailsView.cityName.text = "forecast of \(name) is: "
                        self.detailsView.cityRainExpectation.text = "rain expectation is: \(rain)"
                        self.detailsView.cityTemp.text = "tempreture is: \(tempreture)"
                        self.detailsView.cityHumidity.text = "Humidity is: \(humidity)"
                        self.detailsView.cityWindInfo.text = "wind speed is: \(windSpeed)"
                    }
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
