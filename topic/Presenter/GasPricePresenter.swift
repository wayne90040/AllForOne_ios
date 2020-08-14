//
//  GasPricePresenter.swift
//  topic
//
//  Created by 許維倫 on 2019/10/7.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation
class GasPricePresenter: BasePresenter{
    var process = 0
    var status = ""
    var delegate : ViewControllerBaseDelegate?
    init(delegate:ViewControllerBaseDelegate){
        self.delegate = delegate
    }
/*
    func getGasPrice(GetPrice:Int){
        status = "GetGasPrice"
        let urlsession = UrlSession(url: ServerContentURL.gasprice ,delegate:self)
        let jsonb = JSONBuilder()
        jsonb.addItem(key:"GetPrice", value: GetPrice)
        urlsession.setupJSON(json:jsonb.value())
        urlsession.postJSON()
    }
 */
    
    func GetPrice(type: String){
        status = "GasPrice"
        let urlsession = UrlSession(url: ServerContentURL.gasprice, delegate: self)
        let jsonb = JSONBuilder()
        jsonb.addItem(key: "Type", value: type)
        urlsession.setupJSON(json: jsonb.value())
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
            delegate?.PresenterCallBack(datadic: jsondictionary, success: false, type:status)
        }
    }
    
    override func SessionFinishError(error: NSError) {
        delegate?.PresenterCallBackError(error: error, type: "")
    }
}
