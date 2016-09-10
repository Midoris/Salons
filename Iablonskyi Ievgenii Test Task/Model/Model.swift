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
    var salons = [Salon]()
    
    // MARK: - Methods
    // get data from API
    internal func getDataFromUrl(url: String) {
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                let salonsDict = json.dictionary
                self.parseSalonsFromJsonDict(salonsDict!)
            case .Failure(let error):
                print("Request failed with error: \(error)")
                self.callNotifyUser()

            }
        }
    }
    
    // parse data from API
    private func parseSalonsFromJsonDict(dict: [String: JSON]?) {
        guard dict != nil else {
            callNotifyUser()
            return }
        self.salons.removeAll() // clean Salons array in case of reloading 
        for (_, subJson):(String, JSON) in dict!["salons"]! {
            let name = subJson["name"].string
            let website = subJson["website"].string
            let originalProfileImageUrl = subJson["profile_image_urls"]["original"].string
            guard name != nil && website != nil && originalProfileImageUrl != nil else {
                callNotifyUser()
                return
            }
            let salon = Salon(name: name!, website: website!, originalProfileImageUrl: originalProfileImageUrl!)
            self.salons.append(salon)
        }
        callUpdateUI()
    }
    
    // calls to SalonsVC
    private func callUpdateUI() {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ParsingKey, object: self)
    }
    
    private func callNotifyUser() {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.ErrorKey, object: self)
    }
    
    
}