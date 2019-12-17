//
//  ApiManager.swift
//  SujitIOSTest
//
//  Created by Admin on 12/17/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Alamofire

typealias SuccessClosure = ([String: AnyObject]?) -> Void
typealias ErrorClosure = (NSError) -> Void
typealias SuccessBlock = ([AnyObject]?) -> Void

final class ApiManager {
    private init() {
    }
    
    static let sharedManager = ApiManager()
    
    //MARK:- Get CountryInfo
    func getCountryInfo(url: String, success: SuccessBlock?, failure: @escaping ErrorClosure){
        Alamofire.request(url).responseString { response in
            if let jsonData = response.result.value {
                //var countryInfo = [CountryModel]()
                let dict = self.convertToDictionary(text: jsonData)
                if let countryDic = dict {
                    let title = countryDic["title"] as? String
                    UserDefaults.standard.set(title, forKey: "TITLE")
                    let countryArr = countryDic["rows"] as? NSArray
                    
                    success!(countryArr as [AnyObject]?)
                    
                }
            }
        }
    }
    
    //MARK:- Convert String to Dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

