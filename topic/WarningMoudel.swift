//
//  WarningMoudel.swift
//  topic
//
//  Created by 許維倫 on 2019/11/11.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation

class Warning: Codable {
    var warning: String?
    var date: String?
    var time: String?
    
    init(){
        warning = ""
        date = ""
        time = ""
    }
}
