//
//  fetchData.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 20/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import MapKit
import RealmSwift


extension MainController{
    
    func fetch(){
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let curDate = Date.init()
        let urlString:String = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&endtime=\(format.string(from: curDate))&limit=100&orderby=time"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
//        self.data = []
        DispatchQueue.global().async {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            let sessions = URLSession.init(configuration: config)
                sessions.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil{
                    print(error)
                    return
                }
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode == 200{
                    self.editData(data: JSON(data))
                }
                
                
            }).resume()
        }
    }
    
    func editData(data:JSON){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss a"
        for quake in data["features"]{
            let whereArray = quake.1["properties"]["place"].stringValue.components(separatedBy: ", ")
            self.data.append(Earthquake(type: quake.1["properties"]["type"].stringValue, when: dateFormatter.string(from:Date.init(timeIntervalSince1970:TimeInterval(quake.1["properties"]["time"].floatValue/1000.0))), whereTitle: whereArray.count == 2 ? whereArray[0] : "Near the", whereSubTitle: whereArray.count == 2 ? whereArray[1] : whereArray[0], mag: round(quake.1["properties"]["mag"].floatValue*10)/10, location: CLLocation(latitude: quake.1["geometry"]["coordinates"][1].doubleValue, longitude: quake.1["geometry"]["coordinates"][0].doubleValue)))
        }
        self.reloadData(data: data)
    }
    
    func reloadData(data:JSON){
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = 0
            let realm = try! Realm()
            
            try! realm.write {
                if realm.objects(Settings).count == 0{
                    let lastQuake = Settings()
                    lastQuake.lastQuakeId = data["features"][0]["id"].stringValue
                    realm.add(lastQuake)
                }else{
                    let settings = realm.objects(Settings)[0]
                    settings.lastQuakeId = data["features"][0]["id"].stringValue
                }
            }
            
            if #available(iOS 10.0, *) {
                if (self.tableView.refreshControl?.isRefreshing)!{
                    self.tableView.refreshControl?.endRefreshing()
                }
            } else {
                // nothing
            }
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.loadingDataIndicator.stopAnimating()
        }
    }
    
    
}
