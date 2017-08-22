
//
//  EarthquakeModel.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 20/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Earthquake{
    
    var type:String
    var when:String
    var whereTitle:String
    var whereSubTitle:String
    var mag:Float
    var location:CLLocation
}
