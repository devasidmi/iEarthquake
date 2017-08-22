//
//  MagCell.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 20/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import Foundation
import UIKit

class MagCell : UITableViewCell{
    
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var magLabel: UILabel!
    
    @IBOutlet weak var whereTitle: UILabel!
    @IBOutlet weak var whereSubTitle: UILabel!
    @IBOutlet weak var magCircle: CircleMag!
    
    func getMagColor(mag:Float) -> UIColor {
        var goal:Float = mag
        goal = round(goal)
        
        switch goal {
        case 0:
            return UIColor(red:0.29, green:0.48, blue:0.65, alpha:1.0)
        case 1:
            return UIColor(red:0.02, green:0.71, blue:0.70, alpha:1.0)
        case 2:
            return UIColor(red:0.06, green:0.79, blue:0.79, alpha:1.0)
        case 3:
            return UIColor(red:0.96, green:0.65, blue:0.14, alpha:1.0)
        case 4:
            return UIColor(red:1.00, green:0.49, blue:0.31, alpha:1.0)
        case 5:
            return UIColor(red:0.99, green:0.40, blue:0.27, alpha:1.0)
        case 6:
            return UIColor(red:0.91, green:0.37, blue:0.25, alpha:1.0)
        case 7:
            return UIColor(red:0.88, green:0.23, blue:0.13, alpha:1.0)
        case 8:
            return UIColor(red:0.85, green:0.20, blue:0.09, alpha:1.0)
        case 9:
            return UIColor(red:0.75, green:0.22, blue:0.14, alpha:1.0)
        default:
            return UIColor.red
        }
    }    
}
