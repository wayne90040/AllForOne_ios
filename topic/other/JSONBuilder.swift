//
//  JSONBuilder.swift
//  topic
//
//  Created by 許維倫 on 2019/10/7.
//  Copyright © 2019 許維倫. All rights reserved.
//

import Foundation
// 建立JSON格式字串類別
class JSONBuilder{
    
    var dictionary = [String:Any]()
    fileprivate var dictionaryJson = [String:String]()
    fileprivate var json:String = ""    ///Dictionary型別轉存JSON Object
    ///Dictionary型別轉存JSON Object
    func addObject<T>(key:String,dictionary:Dictionary<String, T>){
        let dictionaryString:String = dictionary.description
        self.dictionaryJson[key] = dictionaryString
        self.dictionary[key] = dictionary
        
    }
    ///新增項目存入JSON
    func addItem<T>(key:String,value:T){
        self.dictionaryJson[key] = value as? String
        self.dictionary[key] = value
    }
    ///Array型別轉存JSON Array
    func addArray<T>(key:String,array:Array<T>){
        let aryStr = array.description.replacingOccurrences(of: "\"", with: "")
        self.dictionaryJson[key] = "\(aryStr)"
        self.dictionary[key] = "\(aryStr)"
    }
    ///Return String JSON
    //    func value()->String{
    //        var json = self.json
    //        json = self.dictionaryJson.debugDescription
    //        json = json.stringByReplacingOccurrencesOfString("[", withString: "{", options: .AnchoredSearch , range: nil)
    //
    //        let start = json.endIndex.advancedBy(-1)
    //        json = json.stringByReplacingOccurrencesOfString("]", withString: "}", options: .AnchoredSearch, range: start..<json.endIndex)
    //
    //        return "\(json)"
    //    }
    ///Return JSON Dictionary
    func value()->Dictionary<String, Any>{
        return self.dictionary
    }
    ///清除JSON Data
    func clear(){
        self.dictionary.removeAll()
        self.dictionaryJson.removeAll()
        self.json = ""
    }
}

