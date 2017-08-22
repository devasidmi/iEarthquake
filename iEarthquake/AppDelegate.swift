//
//  AppDelegate.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 20/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,URLSessionDelegate, URLSessionDataDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        UIApplication.shared.registerUserNotificationSettings(.init(types: [.alert,.badge,.sound], categories: nil))
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        checkNewQuake()
        completionHandler(.failed)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func checkNewQuake(){
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let endDate = format.string(from: Date.init())
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let url = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&endtime=\(endDate)&limit=1&orderby=time".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        session.dataTask(with: URL(string: url!)!).resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data){
        let jsonData = JSON(data)
        let realm = try! Realm()
        if jsonData != nil{
            let nowLastId = jsonData["features"][0]["id"].stringValue
            if realm.objects(Settings)[0].lastQuakeId != nowLastId{
                sendNotification(nowLastId: nowLastId)
            }
        }
    }
    
    func sendNotification(nowLastId:String){
        let realm = try! Realm()
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertBody = "We have new data about Earthquakes! Check it out!"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        localNotification.fireDate = Date.init(timeIntervalSinceNow: 1)
        localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber+1
        UIApplication.shared.scheduleLocalNotification(localNotification)
        try! realm.write {
            realm.objects(Settings)[0].lastQuakeId = nowLastId
        }
    }
    
}

