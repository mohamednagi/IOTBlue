//
//  ViewController.swift
//  IotBlue
//
//  Created by Sierra on 6/19/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var mapController: MapController!
    var locationManager = CLLocationManager()
    var latitude:Double = 0
    var longtude:Double = 0
    var savedTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        mapController = MapController()
        mapController.mapView = self
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.choosingLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1
        self.mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func choosingLocation(gestureRecognizer : UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            mapController.alertMessage()
            let point = gestureRecognizer.location(in: self.mapView)
            let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            latitude = coordinate.latitude
            longtude = coordinate.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = savedTitle
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
    }
}

