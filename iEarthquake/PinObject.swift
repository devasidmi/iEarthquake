//
//  Pin.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 20/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Pin:NSObject,MKAnnotation{
    
    var title: String?
    var subtitle: String?
    
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle:String,location:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = location
    }
    
}
