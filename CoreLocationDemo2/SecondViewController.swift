//
//  SecondViewController.swift
//  CoreLocationDemo2
//
//  Created by Amanda Demetrio on 9/13/18.
//  Copyright © 2018 Amanda Demetrio. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //From documentation: "causes the map view to center the map on that location and begin tracking the user’s location. If the map is zoomed out, the map view automatically zooms in on the user’s location, effectively changing the current visible region"
        mapView.userTrackingMode = .follow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

