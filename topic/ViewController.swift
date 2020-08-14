//
//  ViewController.swift
//  topic
//
//  Created by 許維倫 on 2019/5/13.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, ViewControllerBaseDelegate{
    @IBOutlet weak var pageControl: UIPageControl!
    
    var index: Int = 0
    var tableViewSection = [String](), tableViewSectionUnder = [String]()
    // Moudel & Presenter
    var gasprice = GasPrice(), gaspricepresenter: GasPricePresenter?
    var bikes = Bikes(), bikepresenter: BikePresenter?, distance = Double()
    var aqi = AQI(), aqipresenter: AqiPresenter?
    var weather = Weather(), weatherpresenter: WeatherPresenter?
    
    var loadactivity = LoadActivity()
    var cityName: String = ""

    var refreshControl: UIRefreshControl! // 宣告元件
    let userdefault = UserDefaults.standard
    
    let locationManager: CLLocationManager = CLLocationManager() // 設定定位管理器
    @IBOutlet weak var mainTableView: UITableView! // 主畫面的TableView
    @IBOutlet weak var gpsLabel: UILabel! // 地理資訊
    
    // button切換Section設定畫面
    @IBAction func toSectionset(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goSectionset", sender: self)
    }
    
    var location = CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0) {
        didSet {
            postJson()
        }
    }
    
    // MARK: - view cyclelife
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadactivity.showActivityIndicator(self.view)
        
        registerCell()
        mainTableView.delegate = self
        mainTableView.dataSource = self
    
        refreshControl = UIRefreshControl() // 初始化refresh元件
        mainTableView.addSubview(refreshControl)  // 加到tableview裡
        
        // 定位相關設定
        locationManager.delegate = self //設定服務代理
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 設定最佳精確度
        locationManager.distanceFilter = 10 // 距離多遠更新一次
        locationManager.requestAlwaysAuthorization() // 取得gps授權
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        if  locationManager.location != nil{
            location = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0 , longitude: 0.0)
        }
        
        let pages = userdefault.value(forKey: "Cities") as? [String] ?? ["目前位置"]
        if pages.count == 1{
            pageControl.isEnabled = true
            pageControl.numberOfPages = 1
            pageControl.currentPage = 1
        }else{
            pageControl.numberOfPages = pages.count
            pageControl.currentPage = index
        }
    
        locationEncode(address: cityName)
        postJson()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Func
    
    func postJson(){
        gaspricepresenter = GasPricePresenter(delegate: self)
        gaspricepresenter?.GetPrice(type: "All")
        
        bikepresenter = BikePresenter(delegate: self)
        bikepresenter?.getBikes(City: "Taipei")
        
        bikepresenter = BikePresenter(delegate: self)
        bikepresenter?.CloseBike(Longitude: location.longitude, Latitude: location.latitude, City: "Taipei", Type: 1)
        
        aqipresenter = AqiPresenter(delegate: self)
        aqipresenter?.Aqi(Longitude: location.longitude, Latitude: location.latitude)
        
        weatherpresenter = WeatherPresenter(delegate: self)
        weatherpresenter?.postWeather(Longitude: location.longitude, Latitude: location.latitude)
        
    }
    
    @objc func aqiTapAction(){
        self.performSegue(withIdentifier: "toAqiDetailNav", sender: nil)
    }
    
    @objc func weatherTapAction(){
        self.performSegue(withIdentifier: "toWeatherDetailNav", sender: nil)
    }

    
    // MARK: - TableView Delegate & DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSection.count // Section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = self.weather
        
        switch tableViewSection[indexPath.section]{
        case "油價":
            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath)as! PriceTableViewCell
            cell.selectionStyle = .none
            cell.oilView.layer.cornerRadius = 10
            cell.oilView.layer.shadowOffset = CGSize(width: 0, height: 5)
            cell.oilView.layer.shadowOpacity = 0.7
            cell.oilView.layer.shadowRadius = 5
            cell.oilView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
            
            cell.unleadpriceLabel.text = gasprice.Unleaded.description
            cell.superpriceLabel.text = gasprice.Super.description
            cell.supremepriceLabel.text = gasprice.Supreme.description
            cell.diesepriceLabel.text = gasprice.Diesel.description
            
            return cell
            
        case "台北Bike":
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeCell", for: indexPath)as! TaipeiBikeTableViewCell
            let bike = bikes.bikes
            cell.cellbuttonDelegate = self
            cell.bikeView.layer.cornerRadius = 10
            cell.closeView.layer.cornerRadius = 10
            cell.bikeView.layer.shadowOffset = CGSize(width: 0, height: 5)
            cell.bikeView.layer.shadowOpacity = 0.7
            cell.bikeView.layer.shadowRadius = 5
            cell.bikeView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
            
            if bike.count > 0{
                cell.cityName.text = "台北Bike"
                cell.closeStationLbl.text? = bikes.bikes[0].StationName_zh
                cell.closeRentCnt.text? = bikes.bikes[0].AvailableRentBikes.description
                cell.closeReturnCnt.text? = bikes.bikes[0].AvailableReturnBikes.description
                cell.closeTitleLbl.text? = "距離" + distance.description + "KM"
            }
            
            cell.closeTitleLbl.layer.cornerRadius = 2
            cell.closeTitleLbl.backgroundColor = .gray
            cell.selectionStyle = .none
            
            return cell
            
        case "環境":
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemperatureCell", for: indexPath)as! TemperatureTableViewCell
            let aqiTap = UITapGestureRecognizer(target: self, action: #selector(aqiTapAction))
            let weatherTap = UITapGestureRecognizer(target: self, action: #selector(weatherTapAction))
            
            cell.cellbuttonDelegate = self
            
            // AQI
            cell.aqiView.layer.cornerRadius = 10
            cell.aqiView.layer.shadowOffset = CGSize(width: 0, height: 5)
            cell.aqiView.layer.shadowOpacity = 0.7
            cell.aqiView.layer.shadowRadius = 5
            cell.aqiView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
            cell.aqiView.addGestureRecognizer(aqiTap)
            cell.aqiValue.text? = aqi.AQI
            cell.aqiStatus.text? = aqi.AQIStatus
            cell.aqiImg.image = UIImage(named: aqi.getAQIImg())
           
            cell.pmTwoValue.text? = aqi.PM25
            cell.pmTwoStatus.text = aqi.PM25Status
            cell.pmTwoImg.image = UIImage(named: aqi.getPM25Img())
            
            
            // Weather
            cell.weatherView.layer.cornerRadius = 10
            cell.weatherView.layer.shadowOffset = CGSize(width: 0, height: 5)
            cell.weatherView.layer.shadowOpacity = 0.7
            cell.weatherView.layer.shadowRadius = 5
            cell.weatherView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
            cell.weatherView.addGestureRecognizer(weatherTap)
            
            cell.uviValue.text? = weather.H_UVI
            cell.uviStatusLabel.text = "test"
            cell.temImage.image = UIImage(named: String("Green"))
            cell.temperatureValue.text = weather.TEMP

            cell.selectionStyle = .none
            
            return cell
            
        case "現在天氣":
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherPicTableViewCell
                
            cell.weatherPicView.layer.cornerRadius = 10
            cell.weatherPicView.layer.shadowOffset = CGSize(width: 0, height: 5)
            cell.weatherPicView.layer.shadowOpacity = 0.7
            cell.weatherPicView.layer.shadowRadius = 5
            cell.weatherPicView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
            
            cell.temLbl.text? = weather.D_TN + " ~ " + weather.D_TX
            cell.rainfallLbl.text? = weather.RAINFALL
            cell.wxLabel.text? = ""
            cell.selectionStyle = .none
          
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    // Row的高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableViewSection[indexPath.section] {
        case "環境":
            return 160
        case "現在天氣":
            return 280
        case "油價":
            return 250
        case "台北Bike":
            return 100
        default:
            return 50
        }
    }
    
    // 設定header的View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")as! HeaderSection
        return title
    }
 
    // header的高
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.001
    }
    
    // TableView 取消section懸停效果
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainTableView! {
            let sectionHeaderHeight = CGFloat(45.0) // headerView的高度
            if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
                
                scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0);
                
            } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
                
                scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0);
            }
        }
    }
    
    // 註冊Cell
    func registerCell(){
        mainTableView.register(UINib(nibName: "HeaderSection", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        mainTableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceCell")
        mainTableView.register(UINib(nibName: "TemperatureTableViewCell", bundle: nil), forCellReuseIdentifier: "TemperatureCell")
        mainTableView.register(UINib(nibName: "AirQualityTableViewCell", bundle: nil), forCellReuseIdentifier: "AirQualityCell")
        mainTableView.register(UINib(nibName: "WeatherPicTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
        mainTableView.register(UINib(nibName: "TaipeiBikeTableViewCell", bundle: nil), forCellReuseIdentifier: "BikeCell")
    }
    
    func locationEncode(address: String){
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            
            if error != nil {
                print("错误：\(error!.localizedDescription))")
                return
            }
            if let p = placemarks?[0]{
                self.location = p.location?.coordinate ?? CLLocationCoordinate2DMake(0.0, 0.0)
            } else {
                print("No placemarks!")
            }
        })
       
    }
    
    // 點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        switch tableViewSection[indexPath.section] {
        case "台北Bike":
            if let controller = storyboard?.instantiateViewController(withIdentifier: "TaipeiMainNav") {
                present(controller, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    func locationManager(_ manger: CLLocationManager, didUpdateLocations location:[CLLocation]){
        locationManager.delegate = self
        var curLocation = CLLocation()
        let geoCoder = CLGeocoder()
        
        if index == 0{
            curLocation = location.last!
            geoCoder.reverseGeocodeLocation(curLocation, preferredLocale: nil , completionHandler: {(placemarks, error) -> Void in
                
                if error != nil { return }
               
                /*  name            街道地址
                 *  country         國家
                 *  province        省籍
                 *  locality        萬華區
                 *  route           街道、路名
                 *  streetNumber    門牌號碼
                 *  postalCode      郵遞區號
                 *   subAdministrativeArea 台北市
                 */
                // 回傳地理資訊
                if placemarks != nil && (placemarks?.count)! > 0{
                    let placemark = (placemarks?[0])! as CLPlacemark
                    //這邊拼湊轉回來的地址
                    self.gpsLabel.text = placemark.locality
                }
            })
        }else{
            let cities = userdefault.value(forKey: "Cities") as? [String] ?? ["目前位置"]
            let city = String(cities[index].suffix(3))
            gpsLabel.text = city
        }
    }
    
    // 刷新頁面
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing{
            mainTableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    
    // MARK: - ViewControllerBaseDelegate
    
    func PresenterCallBack(datadic: NSDictionary, success: Bool, type: String) {
        if success{
            DispatchQueue.main.async{
                switch type{
                case "GasPrice":
                    self.gasprice = self.covertToModel(jsonDic: datadic, item: GasPrice())
                    
                case "Bikes":
                    self.bikes = self.covertToModel(jsonDic: datadic, item: Bikes())
                    
                case "CloseBike":
                    self.bikes = self.covertToModel(jsonDic: datadic, item: Bikes())
                    let bike = self.bikes.bikes[0]
                    let bikeLocation = CLLocation(latitude: bike.StationLatitude, longitude: bike.StationLongitude)
                    let userLocation = CLLocation(latitude: self.location.latitude, longitude: self.location.longitude)
                    self.distance = round(bikeLocation.distance(from: userLocation) / 1000)
                    
                case "Aqi":
                    self.aqi = self.covertToModel(jsonDic: datadic, item: AQI())
                    self.aqi.setAQIImg(status: self.aqi.AQIStatus)
                    self.aqi.setPM25Img(status: self.aqi.PM25Status)
                    
                case "Weather":
                    self.weather = self.covertToModel(jsonDic: datadic, item: Weather())
                   
                default: break
                }
                
                self.mainTableView.reloadData()
                self.loadactivity.hideActivityIndicator(self.view)
            }
        }
    }
    
    func PresenterCallBackError(error: NSError, type: String) {
        DispatchQueue.main.async {
            self.loadactivity.hideActivityIndicator(self.view)
        }
    }
    
    func covertToModel<T: Decodable>(jsonDic: NSDictionary, item: T) -> T {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonDic, options: [])
            let decoder: JSONDecoder = JSONDecoder()
            let jsonModel = try decoder.decode(T.self, from: data)
            return jsonModel
        } catch {
            return item
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toAqiDetailNav":
            let nav = segue.destination as! UINavigationController
            let vc = nav.topViewController as! AqiDetailViewController
            vc.aqi = self.aqi
            
        case "toWeatherDetailNav":
            let nav = segue.destination as! UINavigationController
            let vc = nav.topViewController as! WeatherDetailViewController
            vc.weather = self.weather
        default: break
            
        }
    }
}


// MARK:- CellButtonDelegate

extension ViewController: CellButtonDelegate{
    
    func toDetail(title: String) {
        
        switch title{
        case "toWeather":
            self.performSegue(withIdentifier: "toWeatherDetailNav", sender: nil)
            
        case "toAqi":
            self.performSegue(withIdentifier: "toAqiDetailNav", sender: nil)
        
        default: break
            
        }
    }
}



