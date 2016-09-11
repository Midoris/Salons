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
    
    // MARK: - Methods
    // get data from API
    internal func getDataFromUrl(url: String, completionHandler: ((isSuccess: Bool, parsedSalons: [Salon]?) -> ())?) {
        var parsedSalons: [Salon]?
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                parsedSalons = self.parsedSalonsFromJsonDict(json.dictionary)
                completionHandler?(isSuccess: response.result.isSuccess, parsedSalons: parsedSalons)
            case .Failure(_):
                self.callNotifyUser()
                completionHandler?(isSuccess: response.result.isSuccess, parsedSalons: parsedSalons)
            }
        }
    }
    
    // parse data from API
    private func parsedSalonsFromJsonDict(dict: [String: JSON]?) -> [Salon]? {
        guard dict != nil else { callNotifyUser()
            return nil }
        var parsedSalons = [Salon]()
        if let preSalons = dict!["salons"] {
            for (_, subJson):(String, JSON) in preSalons {
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
            self.salons = parsedSalons // update Salons array.
            return parsedSalons
        } else {
            return nil
        }
    }
    
    // calls to SalonsVC
    private func callUpdateUI() {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ParsingKey, object: self)
    }
    
    private func callNotifyUser() {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ErrorKey, object: self)
    }
    
}