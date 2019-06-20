//
//  MapController.swift
//  IotBlue
//
//  Created by Sierra on 6/20/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class MapController: NSObject {
    
    var mapView = MapView()
    
    func alertMessage() {
        let controller = UIAlertController(title: "Location Title", message: "please enter this location title", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            let Location = NSEntityDescription.insertNewObject(forEntityName:"Locations", into: Context)
            let textField = controller.textFields![0]
            self.mapView.savedTitle = textField.text!
            Location.setValue(self.mapView.savedTitle, forKey: "title")
            Location.setValue(self.mapView.latitude, forKey: "lat")
            Location.setValue(self.mapView.longtude, forKey: "lon")
            do {
                try Context.save()
                print("Saved")
            } catch  {
                print("Error")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            for annotation in self.mapView.mapView.annotations {
                if annotation.title! == self.mapView.savedTitle {
                    self.mapView.mapView.removeAnnotation(annotation)
                }
            }
        }
        controller.addAction(save)
        controller.addAction(cancel)
        controller.addTextField { (textField) in
            textField.placeholder = "place name"
        }
        mapView.present(controller, animated: true, completion: nil)
    }

}
