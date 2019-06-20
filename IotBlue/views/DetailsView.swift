//
//  DetailsView.swift
//  IotBlue
//
//  Created by Sierra on 6/19/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit

class DetailsView: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityHumidity: UILabel!
    @IBOutlet weak var cityRainExpectation: UILabel!
    @IBOutlet weak var cityWindInfo: UILabel!
    var recievedObject:Locations!
    
    var detailsController:DetailsController!

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsController = DetailsController()
        detailsController.detailsView = self
        guard let lat = recievedObject.lat as? Double else {return}
        guard let lon = recievedObject.lon as? Double else {return}
        detailsController.getData(lat: lat, lon: lon)
    }
}
