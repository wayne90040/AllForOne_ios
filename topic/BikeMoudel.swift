//
//  UBikeMoudel.swift
//  topic
//
//  Created by 許維倫 on 2019/11/5.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation

class Bikes: Codable{
    var type = String()
    var bikes = Array<Bike>()
    
    struct Bike: Codable{
        var StationUID = String()
        var StationID = String()
        var StationName_zh = String()
        var StationLatitude = Double()
        var StationLongitude = Double()
        var stationAddress_zh = String()
        var BikesCapacity = Int()
        var ServiceAvailable = Int()
        var AvailableRentBikes = Int()
        var AvailableReturnBikes = Int()
        var UpdateTime = String()
//        var haversine: Float?
        
    }
}
