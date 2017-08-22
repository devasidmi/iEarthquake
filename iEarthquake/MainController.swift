//
//  ViewController.swift
//  iEarthquake
//
//  Created by Vasiliy Dmitriev on 20/08/2017.
//  Copyright © 2017 Vasiliy Dmitriev. All rights reserved.
//

import UIKit
import MapKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var loadingDataIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var data:[Earthquake] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        fetch()
    }
    
    func refreshAction(){
        fetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MagCell
        
        cell.whenLabel.text = "\(self.data[indexPath.row].when)"
        cell.whereTitle.text = self.data[indexPath.row].whereTitle
        cell.whereSubTitle.text = self.data[indexPath.row].whereSubTitle
        cell.magLabel.text = "\(self.data[indexPath.row].mag)"
        cell.magCircle.backgroundColor = cell.getMagColor(mag: data[indexPath.row].mag)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showLocation", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocation"{
            let backButton = UIBarButtonItem()
            backButton.title = "Back"
            self.navigationItem.backBarButtonItem = backButton
            let dest = segue.destination as! MapController
            dest.data = data[sender as! Int]
        }
    }
}

