//
//  GLoaction.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/18.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import Foundation
import CoreLocation



class GLocation: NSObject,CLLocationManagerDelegate {
    var manager:CLLocationManager?//manager应设为全局变量，否则被释放后不走代理
    func startLocation(){
        if CLLocationManager.locationServicesEnabled(){
            manager = CLLocationManager()
            manager?.delegate = self
            manager?.desiredAccuracy = kCLLocationAccuracyBest
            manager?.distanceFilter = 100
//            if isSystemEqualOrGreateriOS8(){
//                manager?.requestAlwaysAuthorization()
//            }
            manager?.requestAlwaysAuthorization()
            manager?.startUpdatingLocation()
        }else{
            GLog(message: "请先打开定位授权")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        GLog(message: "\(error)")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        GLog(message: "\(status)")
    }
    func searchAddress(location:CLLocation){
        let coder = CLGeocoder()
        //尾随闭包无需跟参数类型，直接将数据取回
        coder.reverseGeocodeLocation(location) { (marks,error) in
            if (marks?.count)!>0{
                for mark in marks!{
                    GLog(message: mark.name!)
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count>0{
            manager.stopUpdatingLocation()
            let location = locations[0]
            searchAddress(location: location)
        }
    }
}
