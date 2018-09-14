//
//  AppDelegate.swift
//  CoreLocationDemo2
//
//  Created by Amanda Demetrio on 9/13/18.
//  Copyright © 2018 Amanda Demetrio. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    
    //Object Used to transform lat, long into address
    static let geoCoder = CLGeocoder()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Asks the user to send them notifications
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
        //Asks the user to access their location
        locationManager.requestAlwaysAuthorization()
        //Starts listening for the user's location
        locationManager.startMonitoringVisits()
        locationManager.delegate = self
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        // create CLLocation from the coordinates of CLVisit
        let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
        // Get location description
        //Here, you ask geoCoder to get placemarks from the location. The placemarks contain a bunch of useful information about the coordinates, including their addresses. You then create a description string out of the first placemark. Once you have the description string, you call newVisitReceived(_:description:).
        AppDelegate.geoCoder.reverseGeocodeLocation(clLocation) { placemarks, _ in
            if let place = placemarks?.first {
                let description = "\(place)"
                self.newVisitReceived(visit, description: description)
            }
        }

    }
    
    func newVisitReceived(_ visit: CLVisit, description: String) {
        let location = Location(visit: visit, descriptionString: description)
        //Setting up the notification content
        let content = UNMutableNotificationContent()
        content.title = "New entry"
        content.body = location.description
        content.sound = .default()
        //Create a one second long trigger and notification request with that trigger.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: location.dateString, content: content, trigger: trigger)
        //Schedule the notification by adding the request to notification center.
        center.add(request, withCompletionHandler: nil)

        // Save location to disk
    }
    
    
}

