//
//  ViewControllerBaseDelegate.swift
//  topic
//
//  Created by 許維倫 on 2019/10/7.
//  Copyright © 2019 許維倫. All rights reserved.
//

import UIKit
protocol ViewControllerBaseDelegate {
    func PresenterCallBack(datadic:NSDictionary,success:Bool,type:String)
    func PresenterCallBackError(error:NSError,type:String)
}
