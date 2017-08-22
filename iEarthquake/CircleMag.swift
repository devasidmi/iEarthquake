//
//  CircleMag.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 20/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CircleMag : UIView{
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width/2
    }
}
