//
//  HomePage-Map.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/22.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import Foundation

class CarAnnotationView:BMKAnnotationView{
    var imageView:UIImageView!
    override init!(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.backgroundColor = UIColor.clear
        
        imageView = UIImageView(image: UIImage(named: "map-taxi.png"))
        imageView.frame = self.bounds
        self.addSubview(imageView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HomePage{
    //    MARK:baiduMap
    func addMapview(){
        _mapView = BMKMapView(frame: self.view.frame)
        _mapView?.zoomLevel = 11
        _mapView?.delegate = self
        self.view.addSubview(_mapView!)
        
        startLocation()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        _mapView?.delegate = self
//    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView?.delegate = nil
    }
    func startLocation(){
        _mapService = BMKLocationService()
        _mapService?.delegate = self
        _mapService?.startUserLocationService()
//        _mapView?.showsUserLocation
        
        _coordinate = CLLocationCoordinate2D(latitude: OriginalY, longitude: OriginalX)
    }
    func addAnotation(){
        
        if(_annotation != nil){
            _mapView?.removeAnnotation(_annotation)
        }else{
            _annotation = BMKPointAnnotation()
        }
        _annotation?.coordinate = _coordinate!
        _annotation?.title = "A Car"
        _mapView?.addAnnotation(_annotation)
    }
    func startTimer(){
        _timer = Timer(timeInterval: 1, target: self, selector: #selector(runTime), userInfo: nil, repeats: true)
        _timer?.fire()
    }
    func runTime(){
//        _coordinate!.latitude += 0.01
//        _coordinate!.longitude += 0.01
        var x = _coordinate!.longitude
        var y = _coordinate!.latitude
//        if(y == OriginalY && x<OriginalX+0.1){
//            x += 0.01
//        }else if(x == OriginalX+0.1 && y<OriginalY+0.1){
//            y += 0.01
//        }else if(y == OriginalY+0.1 && x>OriginalX){
//            x -= 0.01
//        }else if(x == OriginalX && y>OriginalY){
//            y -= 0.01
//        }
        if(x<OriginalX+0.1||y<OriginalY+0.1){
            x += 0.01
            y += 0.01
        }else{
            x -= 0.1
            y -= 0.1
        }
//        print("x:\(x)   y:\(y)")
        _coordinate!.latitude = y
        _coordinate!.longitude = x
        
        addAnotation()
    }
    func stopTimer(){
        _timer?.invalidate()
    }
    func getCarArrivedTime(){
        let point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(39.915,116.404))
        let point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(38.915,115.404))
        let distance = BMKMetersBetweenMapPoints(point1, point2)
        let time = distance/(50*1000)
        GLog(message: "汽车将在\(time)小时后到达")
    }
//    MARK:-mapViewDelegate
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        let car = CarAnnotationView(annotation: annotation, reuseIdentifier: "PID")
        
        car?.isDraggable = false
        
        return car
    }
//    MARK:-bmkLocalServiceDelegate
    func didUpdate(_ userLocation: BMKUserLocation!) {
        addAnotation()
        startTimer()
//        getCarArrivedTime()
    }
}
