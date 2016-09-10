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
    internal func getDataFromUrl(url: String) {
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                //print("json is \(json["salons"])")
                let salonsDict = json.dictionary
                self.parseSalonsFromJsonDict(salonsDict!)
            case .Failure(let error):
                print("Request failed with error: \(error)")
                // TODO: notify user
            }
        }
    }
    
    private func parseSalonsFromJsonDict(dict: [String: JSON]?) {
        guard dict != nil else {
            // TODO: notify user
            return }
        for (_, subJson):(String, JSON) in dict!["salons"]! {
            let name = subJson["name"].string
            let website = subJson["website"].string
            let originalProfileImageUrl = subJson["profile_image_urls"]["original"].string
            guard name != nil && website != nil && originalProfileImageUrl != nil else {
                // TODO: notify user
                return
            }
            let salon = Salon(name: name!, website: website!, originalProfileImageUrl: originalProfileImageUrl!)
            self.salons.append(salon)
        }
    }
    
    
}