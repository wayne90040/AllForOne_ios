//
//  AQIMoudel.swift
//  topic
//
//  Created by Wei Lun Hsu on 2020/8/3.
//  Copyright © 2020 許維倫. All rights reserved.
//

import Foundation


class AQI: Codable{
    var SiteName = String()
    var County = String()
    var AQI = String()
    var Pollutant = String()
    var AQIStatus = String()
    var PM10 = String()
    var PM25 = String()
    var WindSpeed = String()
    var WindDir = String()
    var PM10Avg = String()
    var PM25Avg = String()
    var Date = String()
    var Time = String()
    var So2 = String()
    var Co = String()
    var O3 = String()
    var So2Avg = String()
    var PM25Status = String()
    var AQIImg: String?, PM25Img: String?
    
    init() {
        AQIImg = ""
        PM25Img = ""
    }
    
    internal func setAQIImg(status: String){
        switch status{
        case "良好":
            AQIImg = "Green"
        case "普通":
            AQIImg = "Yellow"
        case "對所有族群不健康":
            AQIImg = "Red"
        case "對敏感族群不健康":
            AQIImg = "Orange"
        default:
            AQIImg = "Gray"
        }
    }
    
    internal func getAQIImg() -> String{
        return AQIImg ?? ""
    }
    
    internal func setPM25Img(status: String){
        switch status{
        case "良好":
            PM25Img = "Green"
        case "普通":
            PM25Img = "Yellow"
        case "對敏感族群不健康":
            PM25Img = "Orange"
        case "不健康":
            PM25Img = "Red"
        case "非常不健康":
            PM25Img = "Purple"
        case "危險":
            PM25Img = "Brown"
        default:
            PM25Img = "Gray"
        }
    }
    
    internal func getPM25Img() -> String{
        return PM25Img ?? ""
    }
}
