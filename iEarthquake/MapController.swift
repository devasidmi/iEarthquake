//
//  MapController.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 20/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {

    var data:Earthquake? = nil
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let distance:CLLocationDistance = 200000
        let pin:MKAnnotation = Pin(title: (self.data?.type)!, subtitle: "\((self.data?.mag)!)", location: (self.data?.location.coordinate)!)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance((self.data?.location.coordinate)!, distance, distance), animated: true)
         mapView.addAnnotation(pin)
        mapView.selectAnnotation(pin, animated: true)
    }
}
