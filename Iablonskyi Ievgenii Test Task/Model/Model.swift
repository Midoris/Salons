//
//  Model.swift
//  Iablonskyi Ievgenii Test Task
//
//  Created by тигренок  on 10/09/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Model {
    
    // MARK: - Variabels
    internal var salons = [Salon]() {
        didSet {
            callUpdateUI()
        }
    }
    
    
    //    internal func getDataFromUrl(url: String) {
    //        self.get(url) { (responseObject) in
    //            print("responseObject is \(responseObject)")
    //            self.salons = responseObject
    //
    //
    //            return responseObject
    //        }
    ////        var parseddSalons: [Salon]?
    ////        Alamofire.request(.GET, url).validate().responseJSON { response in
    ////            switch response.result {
    ////            case .Success(let data):
    ////                let json = JSON(data)
    ////                if let salonsDict = json.dictionary {
    ////                   parseddSalons = self.parseSalonsFromJsonDict(salonsDict)!
    ////                }
    ////            case .Failure(_):
    ////                self.callNotifyUser()
    ////            }
    ////        }
    ////        defer {
    ////            print("parseddSalons : \(parseddSalons)")
    ////        }
    //
    //    }
    
    // MARK: - Methods
    // get data from API
    internal func getDataFromUrl(url: String, completionHandler: (([Salon]?) -> ())?) {
        var parsedSalons: [Salon]?
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                parsedSalons = self.parseSalonsFromJsonDict(json.dictionary)
                completionHandler?(parsedSalons)
            case .Failure(_):
                self.callNotifyUser()
            }
        }
    }
    
    // parse data from API
    private func parseSalonsFromJsonDict(dict: [String: JSON]?) -> [Salon]? {
        guard dict != nil else { callNotifyUser()
            return nil }
        var parsedSalons = [Salon]()
        for (_, subJson):(String, JSON) in dict!["salons"]! {
            let name = subJson["name"].string
            let website = subJson["website"].string
            let originalProfileImageUrl = subJson["profile_image_urls"]["original"].string
            guard name != nil && website != nil && originalProfileImageUrl != nil else {
                callNotifyUser()
                return nil
            }
            let salon = Salon(name: name!, website: website!, originalProfileImageUrl: originalProfileImageUrl!)
            parsedSalons.append(salon)
        }
        if parsedSalons.count > 0 {
            self.salons = parsedSalons
        }
        return parsedSalons
    }
    
    // calls to SalonsVC
    private func callUpdateUI() {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ParsingKey, object: self)
    }
    
    private func callNotifyUser() {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ErrorKey, object: self)
    }
    
    
}