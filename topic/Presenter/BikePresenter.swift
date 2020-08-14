//
//  TaipeiBikePresenter.swift
//  topic
//
//  Created by 許維倫 on 2019/10/30.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation
class BikePresenter: BasePresenter{
    var process = 0
    var status = ""
    var delegate : ViewControllerBaseDelegate?
    
    init(delegate:ViewControllerBaseDelegate){
        self.delegate = delegate
    }
    
    func getBikes(City: String){
        status = "Bikes"
        let urlsession = UrlSession(url: ServerContentURL.bike ,delegate:self)
        let jsonb = JSONBuilder()
        
        jsonb.addItem(key:"City", value: City)
        urlsession.setupJSON(json:jsonb.value())
        urlsession.postJSON()
    }
    
    func CloseBike(Longitude: Double, Latitude: Double, City: String, Type: Int){
        status = "CloseBike"
        let urlsession = UrlSession(url: ServerContentURL.closebike, delegate: self)
        let jsonb = JSONBuilder()
        
        jsonb.addItem(key: "Longitude", value: Longitude)
        jsonb.addItem(key: "Latitude", value: Latitude)
        jsonb.addItem(key: "City", value: City)
        jsonb.addItem(key: "Type", value: Type)
        urlsession.setupJSON(json: jsonb.value())
        urlsession.postJSON()
    }
        
    override func SessionFinish(data: NSData) {
        let urlsession = UrlSession()
        let jsondictionary = urlsession.jsonDictionary(json: data)
//        let result = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        let temp_result = jsondictionary.object(forKey: "result") as? Bool ?? false
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
