//
//  MainPageViewController.swift
//  topic
//
//  Created by 許維倫 on 2019/11/1.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit
import CoreLocation

class MainPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    let userdefault = UserDefaults.standard
    
    @IBAction func toSetting(_ sender: Any) {
        // self.performSegue(withIdentifier: "toSetting", sender: self)
    }
    
    @IBAction func toSearch(_ sender: Any) {
        // self.performSegue(withIdentifier: "toCityView", sender: self)
    }
    
    //var sectionList = ["環境", "現在天氣", "油價", "台北UBike"]
    // var underSectionList = ["新北UBike"] as [String]
    var sectionList = [String]()
    var underSectionList = [String]()
    var city: [String] = ["台北市中正區"]
//     var city = [String]()
    
    var location = CLLocationCoordinate2D(latitude: 120.0 , longitude: 0.0)
    
    // var loction = [["Longitude": 0, "Latitude": 0], ["Longitude": 121.5548065, "Latitude": 25.0287521]]
    // var longitude: Double = 0.0
    // var latitude: Double = 0.0
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> ViewController? {
        
        if index < 0  || index >= city.count{
            return nil
        }else if index == 0{
            if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "main") as? ViewController {
                pageContentViewController.index = index
                if userdefault.value(forKey: "sectionList") as? [String] == nil{
                    userdefault.set(["環境", "現在天氣", "油價", "台北Bike", "天氣警報"], forKey: "sectionList")
                    pageContentViewController.tableViewSection = userdefault.value(forKey: "sectionList") as! [String]
                }else{
                    pageContentViewController.tableViewSection = userdefault.value(forKey: "sectionList") as! [String]
                }
                
                if userdefault.value(forKey: "underSectionList") as? [String] == nil{
                    userdefault.set(["新竹Bike", "新北Bike", "苗栗Bike", "彰化Bike", "屏東Bike", "桃園Bike", "高雄Bike", "台南Bike", "台中Bike", "新北市停車位"], forKey: "underSectionList")
                    pageContentViewController.tableViewSectionUnder = userdefault.value(forKey: "underSectionList") as! [String]
                }else{
                    pageContentViewController.tableViewSectionUnder = userdefault.value(forKey: "underSectionList") as! [String]
                }
                
                return pageContentViewController
            }
        }else{
            if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "main") as? ViewController {
                pageContentViewController.index = index
//                pageContentViewController.tableViewSection = sectionList
                if userdefault.value(forKey: "sectionList") as? [String] == nil{
                    userdefault.set(["環境", "現在天氣", "油價", "台北Bike"], forKey: "sectionList")
                    pageContentViewController.tableViewSection = userdefault.value(forKey: "sectionList") as! [String]
                }else{
                    pageContentViewController.tableViewSection = userdefault.value(forKey: "sectionList") as! [String]
                    
                }
                
                if userdefault.value(forKey: "underSectionList") as? [String] == nil{
                    userdefault.set(["新竹Bike", "新北Bike", "苗栗Bike", "彰化Bike", "屏東Bike", "桃園Bike", "高雄Bike", "台南Bike", "台中Bike", "新北市停車位"], forKey: "underSectionList")
                    pageContentViewController.tableViewSectionUnder = userdefault.value(forKey: "underSectionList") as! [String]
                }else{
                    pageContentViewController.tableViewSectionUnder = userdefault.value(forKey: "underSectionList") as! [String]
                }
                
//                pageContentViewController.cityName = city[index]
//                locationEncode(address: city[index])
//                print(city[index])
//                pageContentViewController.location = location
                return pageContentViewController
            }
        }
       
        return nil
    }
    
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let c = userdefault.value(forKey: "Cities") as? [String] {
            city = c
        }
               
        // Set the data source to itself
        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Segue 頁面傳值
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSetting"{
            let destViewController: TableViewSectionset = segue.destination as! TableViewSectionset
            destViewController.sectionRow = sectionList
            destViewController.sectionInsertRow = underSectionList
        
        }
    }
    */
    func locationEncode(address: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            
            if error != nil {
                print("错误：\(error!.localizedDescription))")
                return
            }
            if let p = placemarks?[0]{
                print("经度：\(p.location!.coordinate.longitude)")
                self.location.longitude = p.location!.coordinate.longitude
                print("纬度：\(p.location!.coordinate.latitude)")
                self.location.latitude = p.location!.coordinate.latitude
               print(self.location)
            } else {
                print("No placemarks!")
            }
        })
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
