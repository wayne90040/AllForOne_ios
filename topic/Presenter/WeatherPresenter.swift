//
//  WeatherPresenter.swift
//  topic
//
//  Created by 許維倫 on 2019/10/8.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation
class WeatherPresenter: BasePresenter{
    var process = 0
    var status = ""
    var delegate : ViewControllerBaseDelegate?
    init(delegate:ViewControllerBaseDelegate){
        self.delegate = delegate
    }
    func postWeather(Longitude: Double, Latitude: Double){
        status = "Weather"
        let urlsession = UrlSession(url: ServerContentURL.weather ,delegate:self)
        let jsonb = JSONBuilder()
        jsonb.addItem(key:"Longitude", value: Longitude)
        jsonb.addItem(key: "Latitude", value: Latitude)
        urlsession.setupJSON(json:jsonb.value())
        urlsession.postJSON()
    }
    override func SessionFinish(data: NSData) {
        let urlsession = UrlSession()
        let jsondictionary = urlsession.jsonDictionary(json: data)
        let result = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        let temp_result = jsondictionary.object(forKey: "result") as! Bool
        if temp_result{
            delegate?.PresenterCallBack(datadic: jsondictionary, success: true, type: status)
        }else{
            delegate?.PresenterCallBack(datadic: jsondictionary, success: false,type:status)
        }
    }
    override func SessionFinishError(error: NSError) {
        delegate?.PresenterCallBackError(error: error, type: "")
    }
}
