//
//  LocationInfo.swift
//  员工请假审批系统
//
//  Created by 姚驷旭 on 16/5/9.
//  Copyright © 2016年 姚驷旭. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol GetLocation : class {
    func getLocation(location :String)
    func getLocationError()
}

class LocationManager :NSObject,CLLocationManagerDelegate {
    
    class var sharedInstance : LocationManager {
        struct Static {
            static let instance: LocationManager = LocationManager()
        }
        return Static.instance
    }
    
    var locationName = ""
    let locationManager = CLLocationManager()
    weak var delegate : GetLocation?
    
    override init() {
        super.init()
    }
    
    
    func startLocation() -> Bool {
        print("\(#function)")
        locationManager.delegate = self
        locationManager.desiredAccuracy = 10
        locationManager.requestWhenInUseAuthorization()
        if !CLLocationManager.locationServicesEnabled() {
            return false
        }
        let currentStatus = CLLocationManager.authorizationStatus()
        if currentStatus != .AuthorizedWhenInUse && currentStatus != .AuthorizedAlways {
            return false
        }
        locationManager.startUpdatingLocation()
        return true
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .NotDetermined: break
        case .Restricted,.Denied:
            print("没有足够的权限访问定位服务!")
        case .AuthorizedAlways , .AuthorizedWhenInUse :
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        locationManager.stopUpdatingLocation()
        let locationName = CLGeocoder()
        
        print("before locationname")
        locationName.reverseGeocodeLocation(location, completionHandler: { (placmark: [CLPlacemark]?, error: NSError?) -> Void in
            guard let plackmark = placmark?.first else {
                return
            }
            
            if plackmark.name != nil {
                self.locationName = plackmark.name!
                let index = self.locationName.startIndex.advancedBy(2)
                self.locationName = self.locationName.substringFromIndex(index)
            }
            print("locationName = \(self.locationName)")
        })
        print("after locationname")
        
        delegate?.getLocation(self.locationName)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.delegate?.getLocationError()
    }
    
}
