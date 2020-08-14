//
//  NTPCMapViewController.swift
//  topic
//
//  Created by 許維倫 on 2019/11/10.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NTPCMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, ViewControllerBaseDelegate{
    func PresenterCallBack(datadic: NSDictionary, success: Bool, type: String) {
        DispatchQueue.main.async {
            self.loadactivity.hideActivityIndicator(self.view)
        }
        
        if let result = datadic["result"] as? Int{
            if result == 1{
                switch type{
                case "GetClosePark":
                    do{
                        datadic.setValue(nil, forKey: "result")
                        // let jsonData = try JSONSerialization.data(withJSONObject: datadic, options: .prettyPrinted)
                        // self.gasPrice = try JSONDecoder().decode([GasPrice].self, from: jsonData)
                        
                        DispatchQueue.main.async {
                            self.ntpc = datadic["parks"] as! [NSDictionary]
                            print(self.ntpc)
                            self.setData()
                        }
                        
                    }catch let error{
                        print("PreWeather error")
                        print(error)
                    }
                
                default:
                    break
                }
                
            }
        }
    }
    
    func PresenterCallBackError(error: NSError, type: String) {
        DispatchQueue.main.async {
            self.loadactivity.hideActivityIndicator(self.view)
        }
    }
    
    

    @IBOutlet weak var mainMap: MKMapView!
    var loadactivity = LoadActivity()
    var refreshControl: UIRefreshControl!
    var circle: MKOverlay?
    var ntpc = [NSDictionary]()
    let locationManager: CLLocationManager = CLLocationManager()
    var parkPresenter: ParkPresenter?
    let userdefault = UserDefaults.standard
    var location = CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        mainMap.delegate = self
        refreshControl = UIRefreshControl() // 初始化refresh元件
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self //設定ViewController為代理人
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //準確度設定
        locationManager.activityType = .automotiveNavigation//移動的模式
        locationManager.startUpdatingLocation() //開始更新位置
        
        let latRange:CLLocationDegrees = 0.01
        let lonRange:CLLocationDegrees = 0.01
        let userLocation = locationManager.location?.coordinate
        let range:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latRange, longitudeDelta: lonRange)
        let appearRegion:MKCoordinateRegion = MKCoordinateRegion(center: userLocation!, span: range)
        
        mainMap.setRegion(appearRegion, animated: true)
        mainMap.showsCompass = true
        // Do any additional setup after loading the view.
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }else{
            print("位址失敗")
        }
        
        if  locationManager.location != nil{
            location = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0)
        }
        
        parkPresenter = ParkPresenter(delegate: self)
        parkPresenter?.getClosePark(Longitude: location.longitude, Latitude: location.latitude, contain: "0", type: "0")
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.loadactivity.showActivityIndicator(self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(){
        var lon: Double
        var lat: Double
        var location:CLLocationCoordinate2D
        for a in ntpc{
            // let annotation = MKPointAnnotation()
            lon = a["Longitude"] as! Double
            lat = a["Latitude"] as! Double
            location = CLLocationCoordinate2DMake(lat, lon )
            let annotation = MyAnnotation(coordinate: location)
           
            annotation.title = (a["NAME"] as! String)
            // annotation.subtitle = (a["AvailableRentBikes"] as! String)
            annotation.subtitle = "狀態:\(a["ParkStatusZh"] as! String)  收費: \(a["PAYCASH"] as! String)"
            mainMap.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView!, viewFor annotation: MKAnnotation!) -> MKAnnotationView! {
        let bikeImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        bikeImage.image = UIImage(named:"parkLocation")
        
        if let temp = annotation as? MyAnnotation{
            var myView = mainMap.dequeueReusableAnnotationView(withIdentifier: "MyPin")
            if myView == nil{
                myView = MKAnnotationView(annotation: temp, reuseIdentifier: "MyPin")
                myView?.image = UIImage(named: "parkLocation")
                
                let button = UIButton(type: .detailDisclosure)
                button.addTarget(self, action: #selector(clickDetail), for: .touchUpInside)
                
                myView?.rightCalloutAccessoryView = button
                myView?.canShowCallout = true
            }else{
                myView?.annotation = annotation
            }
            return myView
        }else{
            return nil
        }
    }
    @objc func clickDetail(){
        let controller = UIAlertController(title: "選擇功能", message: "", preferredStyle: .actionSheet)
        let names = ["導航"]
        
        for name in names {
            let action = UIAlertAction(title: name, style: .default) { (action) in
                if action.title == "導航"{
                    let annotationLon = self.userdefault.value(forKey: "annotionLon") as! CLLocationDegrees
                    let annotationLat = self.userdefault.value(forKey: "annotionLat") as! CLLocationDegrees
                    let targetLoncation = CLLocationCoordinate2D(latitude: annotationLat, longitude: annotationLon)
                    let targetPlacemark = MKPlacemark(coordinate: targetLoncation)
                    let targetItem = MKMapItem(placemark: targetPlacemark)
                    let userMapItem = MKMapItem.forCurrentLocation()
                    let routes = [userMapItem,targetItem]
                    MKMapItem.openMaps(with: routes, launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
                    print(targetLoncation)
                    print(annotationLon, annotationLat)
                    print(userMapItem)
                    print(targetPlacemark)
                    
                }
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let latRange:CLLocationDegrees = 0.01
        let lonRange:CLLocationDegrees = 0.01
        let range:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latRange, longitudeDelta: lonRange)
        let appearRegion:MKCoordinateRegion = MKCoordinateRegion(center: view.annotation!.coordinate, span: range)
        userdefault.set(view.annotation?.coordinate.longitude, forKey: "annotionLon")
        userdefault.set(view.annotation?.coordinate.latitude, forKey: "annotionLat")
        
        mainMap.setRegion(appearRegion, animated: true)
    }
}
