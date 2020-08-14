//
//  ServerContentURL.swift
//  topic
//
//  Created by 許維倫 on 2019/10/7.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation
class ServerContentURL {
    
    static var ip = "https://allforone-back.herokuapp.com/"  // Heroku 主機端
    
    static var gasprice = ip + "GasPrice/"
    static var bike = ip + "Bike/"
    static var closebike = ip + "CloseBike/"
    static var aqi = ip + "AQI/"
    static var weather = ip + "Weather/"
    static var preweather = ip + "PreWeather"
    
//    static var aqi = ip + "aqi/"
    
    static var environmentalWarning = ip + "warning/"
//    static var preweather = ip + "preweather/"
    static var getAllBike = ip + "getAllBike/"
    static var getCloseBike = ip + "getCloseBike/"
    static var getParkNTPC = ip + "parkNTPC/"
    static var warning = ip + "warning/"
}

