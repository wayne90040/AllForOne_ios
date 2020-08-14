//
//  WeatherCollectionTableViewCell.swift
//  topic
//
//  Created by 許維倫 on 2019/10/19.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit

class WeatherCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, ViewControllerBaseDelegate{
    
    var perWeather: NSDictionary=["city": "", "NowPoP": "", "NowWx": "", "NowStartTime": ""]
    var hours: [String] = []
    var preweatherPresenter: PreWeatherPresenter?
    let userDefaults = UserDefaults.standard
    var userLongitude:Double = 121.528056
    var userLatitude:Double = 25.031331
    
    func setDate(now: String)->String{
        let nowHour =  (now as NSString).substring(with: NSMakeRange(0,2))
        return nowHour
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! WeatherCollectionViewCell
        var hour = perWeather["NowStartTime"] as! NSString
        
        if hour != ""{
            hour = hour.substring(with: NSMakeRange(0,2)) as NSString
        }
        
        cell.hourLbl.text? = hour as String
        return cell
    }
    
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        
        preweatherPresenter = PreWeatherPresenter(delegate: self)
        preweatherPresenter?.postPreWeather(Longitude: userLongitude, Latitude: userLatitude)
        
        self.mainCollectionView!.register(UINib(nibName:"WeatherCollectionViewCell", bundle:nil),  forCellWithReuseIdentifier: "collectionCell")
        print(perWeather)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func PresenterCallBack(datadic: NSDictionary, success: Bool, type: String) {
        if let result = datadic["result"] as? Int{
            if result == 1{
                switch type{
                case "PostPreWeather":
                    do{
                        datadic.setValue(nil, forKey: "result")
                        // let jsonData = try JSONSerialization.data(withJSONObject: datadic, options: .prettyPrinted)
                        // self.gasPrice = try JSONDecoder().decode([GasPrice].self, from: jsonData)
                        
                        DispatchQueue.main.async {
                            self.perWeather = datadic
                            // self.userDefaults.set(self.perWeather, forKey: "perWeather")
                            self.mainCollectionView.delegate = self
                            self.mainCollectionView.dataSource = self
                            self.mainCollectionView.reloadData()
                            
                            print(self.perWeather)
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
            print(error)
        }
    }
}
