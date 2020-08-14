//
//  File.swift
//  topic
//
//  Created by 許維倫 on 2019/11/5.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation
// 現在天氣
class Weather: Codable {
    var locationName = String()
    var WDIR = String()
    var WDSD = String()
    var TEMP = String()
    var HUMD = String()
    var RAINFALL = String()
    var H_UVI = String()
    var D_TX = String()
    var D_TXT = String()
    var D_TN = String()
    var D_TNT = String()
}
