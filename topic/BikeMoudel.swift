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

class TaipeiBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class NewTaipeiBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class HsinchuBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class MiaoliBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class ChanghuaBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class PingtungBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class TaoyuanBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class KaohsiungBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class TainanBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}

class TaichungBike: Codable {
    var StationName_zh: String?
    var AvailableRentBikes: String?
    var AvailableReturnBikes: String?
    var haversine: String?
    init(){
        StationName_zh = ""
        AvailableRentBikes = ""
        AvailableReturnBikes = ""
        haversine = ""
    }
}
