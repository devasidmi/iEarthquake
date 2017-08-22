//
//  initMainController.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 21/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import Foundation
import UIKit

extension MainController{
    
    
    func initUI(){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            //nothing
        }
        self.tableView.isHidden = true
    }
}
