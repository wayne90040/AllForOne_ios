//
//  TaipeiCloseBike.swift
//  topic
//
//  Created by 許維倫 on 2019/10/30.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation
class TaipeiCloseBikePresenter: BasePresenter{
    var process = 0
    var status = ""
    var delegate : ViewControllerBaseDelegate?
    init(delegate:ViewControllerBaseDelegate){
        self.delegate = delegate
    }
    func getCloseBike(Longitude:Double, Latitude: Double, type: String, city: String){
        switch city {
        case "Taipei":
            status = "GetBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
        case "NewTaipei":
            status = "GetNewTaipeiBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
        case "Hsinchu":
            status = "GetHsinchuBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
            
        case "MiaoliCounty":
            status = "GetMiaoliBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
        case "ChanghuaCounty":
            status = "GetChanghuaBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
        case "PingtungCounty":
            status = "GetPingtungBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
        case "Taoyuan":
            status = "GetTaoyuanBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
        case "Kaohsiung":
            status = "GetKaohsiungBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
        case "Tainan":
            status = "GetTainanBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
        case "Taichung":
            status = "GetTaichungBike"
            let urlsession = UrlSession(url: ServerContentURL.getCloseBike ,delegate:self)
            let jsonb = JSONBuilder()
            jsonb.addItem(key: "Longitude", value: Longitude)
            jsonb.addItem(key:"Latitude", value: Latitude)
            jsonb.addItem(key: "type", value: type)
            jsonb.addItem(key: "City", value: city)
            urlsession.setupJSON(json:jsonb.value())
            urlsession.postJSON()
       
            
            

        default:
            break
        }
        
    }
    override func SessionFinish(data: NSData) {
        let urlsession = UrlSession()
        let jsondictionary = urlsession.jsonDictionary(json: data)
        let result = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
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
