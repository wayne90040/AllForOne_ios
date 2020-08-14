//
//  parkNTPCMoudel.swift
//  topic
//
//  Created by 許維倫 on 2019/11/10.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation  // 新北市停車位

class ParkNTPC: Codable {
    var NAME: String?
    var DAY: String?
    var HOUR: String?
    var PAYCASH: String?
    var ParkStatus: String? // 判斷是車位狀況
    var ParkStatusZh: String?  // 車位是狀況
    var Haversine: String?  // 距離
    var MEMO: String?
    init(){
        NAME = ""
        DAY = ""
        HOUR = ""
        PAYCASH = ""
        ParkStatus = ""
        ParkStatusZh = ""
        Haversine = ""
        MEMO = ""
    }
}

